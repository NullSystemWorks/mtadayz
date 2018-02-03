//
// water.fx
//


//---------------------------------------------------------------------
// Water settings
//---------------------------------------------------------------------
texture sReflectionTexture;
texture sRandomTexture;
float4 sWaterColor = float4(90 / 255.0, 170 / 255.0, 170 / 255.0, 240 / 255.0 );


//---------------------------------------------------------------------
// Include some common stuff
//---------------------------------------------------------------------
//#define GENERATE_NORMALS      // Uncomment for normals to be generated
#include "mta-helper.fx"


//------------------------------------------------------------------------------------------
// Samplers for the textures
//------------------------------------------------------------------------------------------
sampler3D RandomSampler = sampler_state
{
   Texture = (sRandomTexture);
   MAGFILTER = LINEAR;
   MINFILTER = LINEAR;
   MIPFILTER = LINEAR;
   MIPMAPLODBIAS = 0.000000;
};

samplerCUBE ReflectionSampler = sampler_state
{
   Texture = (sReflectionTexture);
   MAGFILTER = LINEAR;
   MINFILTER = LINEAR;
   MIPFILTER = LINEAR;
   MIPMAPLODBIAS = 0.000000;
};


//---------------------------------------------------------------------
// Structure of data sent to the vertex shader
//---------------------------------------------------------------------
struct VSInput
{
    float3 Position : POSITION0;
    float4 Diffuse : COLOR0;
    float2 TexCoord : TEXCOORD0;
};

//---------------------------------------------------------------------
// Structure of data sent to the pixel shader ( from the vertex shader )
//---------------------------------------------------------------------
struct PSInput
{
    float4 Position : POSITION0;
    float4 Diffuse : COLOR0;
    float3 WorldPos : TEXCOORD0;
    float4 SparkleTex : TEXCOORD1;
};


//------------------------------------------------------------------------------------------
// VertexShaderFunction
//  1. Read from VS structure
//  2. Process
//  3. Write to PS structure
//------------------------------------------------------------------------------------------
PSInput VertexShaderFunction(VSInput VS)
{
    PSInput PS = (PSInput)0;

    // Calculate screen pos of vertex
    PS.Position = MTACalcScreenPosition ( VS.Position );

    // Convert regular water color to what we want
    float4 waterColorBase = float4(90 / 255.0, 170 / 255.0, 170 / 255.0, 240 / 255.0 );
    float4 conv           = float4(30 / 255.0,  58 / 255.0,  58 / 255.0, 200 / 255.0 );
    PS.Diffuse = saturate( sWaterColor * conv / waterColorBase );

    // Set information to do calculations in pixel shader
    PS.WorldPos = MTACalcWorldPosition( VS.Position );


    // Scroll noise texture
    float2 uvpos1 = 0;
    float2 uvpos2 = 0;

    uvpos1.x = sin(gTime/40);
    uvpos1.y = fmod(gTime/50,1);

    uvpos2.x = fmod(gTime/10,1);
    uvpos2.y = sin(gTime/12);

    PS.SparkleTex.x = PS.WorldPos.x / 6 + uvpos1.x;
    PS.SparkleTex.y = PS.WorldPos.y / 6 + uvpos1.y;
    PS.SparkleTex.z = PS.WorldPos.x / 10 + uvpos2.x;
    PS.SparkleTex.w = PS.WorldPos.y / 10 + uvpos2.y;

    return PS;
}


//------------------------------------------------------------------------------------------
// PixelShaderFunction
//  1. Read from PS structure
//  2. Process
//  3. Return pixel color
//------------------------------------------------------------------------------------------
float4 PixelShaderFunction(PSInput PS) : COLOR0
{
    //
    // This was all ripped and modded from the car paint shader, so some of the comments may seem a bit strange
    //

    float brightnessFactor = 0.10;
    float glossLevel = 0.00;

    // Get the surface normal
    float3 vNormal = float3(0,0,1);

    // Micro-flakes normal map is a high frequency normalized
    // vector noise map which is repeated across the surface.
    // Fetching the value from it for each pixel allows us to
    // compute perturbed normal for the surface to simulate
    // appearance of micro-flakes suspended in the coat of paint:
    float3 vFlakesNormal = tex3D(RandomSampler, float3(PS.SparkleTex.xy,1)).rgb;
    float3 vFlakesNormal2 = tex3D(RandomSampler, float3(PS.SparkleTex.zw,2)).rgb;

    vFlakesNormal = (vFlakesNormal + vFlakesNormal2 ) / 2;

    // Don't forget to bias and scale to shift color into [-1.0, 1.0] range:
    vFlakesNormal = 2 * vFlakesNormal - 1.0;

    // To compute the surface normal for the second layer of micro-flakes, which
    // is shifted with respect to the first layer of micro-flakes, we use this formula:
    // Np2 = ( c * Np + d * N ) / || c * Np + d * N || where c == d
    float3 vNp2 = ( vFlakesNormal + vNormal ) ;

    // The view vector (which is currently in world space) needs to be normalized.
    // This vector is normalized in the pixel shader to ensure higher precision of
    // the resulting view vector. For this highly detailed visual effect normalizing
    // the view vector in the vertex shader and simply interpolating it is insufficient
    // and produces artifacts.
    float3 vView = normalize( gCameraPosition - PS.WorldPos );

    // Transform the surface normal into world space (in order to compute reflection
    // vector to perform environment map look-up):
    float3 vNormalWorld = float3(0,0,1);

    // Compute reflection vector resulted from the clear coat of paint on the metallic
    // surface:
    float fNdotV = saturate(dot( vNormalWorld, vView));
    float3 vReflection = 2 * vNormalWorld * fNdotV - vView;

    // Hack in some bumpyness
    vReflection += vNp2;

    // Sample environment map using this reflection vector:
    float4 envMap = texCUBE( ReflectionSampler, vReflection );

    // Premultiply by alpha:
    envMap.rgb = envMap.rgb * envMap.a;

    // Brighten the environment map sampling result:
    envMap.rgb *= brightnessFactor;


    float4 finalColor = 1;

    // Bodge in the water color
    finalColor = envMap + PS.Diffuse * 0.5;
    finalColor += envMap * PS.Diffuse;
    finalColor.a = PS.Diffuse.a;

    return finalColor;
}


//------------------------------------------------------------------------------------------
// Techniques
//------------------------------------------------------------------------------------------
technique water
{
    pass P0
    {
        VertexShader = compile vs_2_0 VertexShaderFunction();
        PixelShader  = compile ps_2_0 PixelShaderFunction();
    }
}

// Fallback
technique fallback
{
    pass P0
    {
        // Just draw normally
    }
}
