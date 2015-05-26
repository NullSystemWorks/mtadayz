--[[ Exports  ]]--
    --[[ Shared ]]--
        local dx = exports.addon_dxgui_v1
        function dxCreateRootPane(...) return dx:dxCreateRootPane(...) end
        function dxGetRootPane(...) return dx:dxGetRootPane(...) end
        function dxRefreshThemes(...) return dx:dxRefreshThemes(...) end
        function dxGetTheme(...) return dx:dxGetTheme(...) end
        function dxGetDefaultTheme(...) return dx:dxGetDefaultTheme(...) end
        function dxGetPosition(...) return dx:dxGetPosition(...) end
        function dxGetSize(...) return dx:dxGetSize(...) end
        function dxGetVisible(...) return dx:dxGetVisible(...) end
        function dxGetElementTheme(...) return dx:dxGetElementTheme(...) end
        function dxGetFont(...) return dx:dxGetFont(...) end
        function dxGetColor(...) return dx:dxGetColor(...) end
        function dxGetColorCoded(...) return dx:dxGetColorCoded(...) end
        function dxGetText(...) return dx:dxGetText(...) end
        function dxGetAlpha(...) return dx:dxGetAlpha(...) end
        function dxSetPosition(...) return dx:dxSetPosition(...) end
        function dxSetSize(...) return dx:dxSetSize(...) end
        function dxSetVisible(...) return dx:dxSetVisible(...) end
        function dxSetElementTheme(...) return dx:dxSetElementTheme(...) end
        function dxSetFont(...) return dx:dxSetFont(...) end
        function dxSetColor(...) return dx:dxSetColor(...) end
        function dxSetColorCoded(...) return dx:dxSetColorCoded(...) end
        function dxSetText(...) return dx:dxSetText(...) end
        function dxSetAlpha(...) return dx:dxSetAlpha(...) end
        function dxMove(...) return dx:dxMove(...) end
        function dxRefreshStates(...) return dx:dxRefreshStates(...) end
        function dxRefreshClickStates(...) return dx:dxRefreshClickStates(...) end
        function guiAttachToDirectX(...) return dx:guiAttachToDirectX(...) end
        function dxGetAlwaysOnTop(...) return dx:dxGetAlwaysOnTop(...) end
        function dxSetAlwaysOnTop(...) return dx:dxSetAlwaysOnTop(...) end
        function dxGetZOrder(...) return dx:dxGetZOrder(...) end
        function dxSetZOrder(...) return dx:dxSetZOrder(...) end
        function dxBringToFront(...) return dx:dxBringToFront(...) end
        function dxMoveToBack(...) return dx:dxMoveToBack(...) end
        function dxDestroyElement(...) return dx:dxDestroyElement(...) end
        function dxDestroyElements(...) return dx:dxDestroyElements(...) end
    --[[ Button ]]--
        function dxCreateButton(...) return dx:dxCreateButton(getThisResource(),...) end
        function dxButtonRender(...) return dx:dxButtonRender(...) end
    --[[ Checkbox ]]--
        function dxCreateCheckBox(...) return dx:dxCreateCheckBox(getThisResource(),...) end
        function dxCheckBoxGetSelected(...) return dx:dxCheckBoxGetSelected(...) end
        function dxCheckBoxSetSelected(...) return dx:dxCheckBoxSetSelected(...) end
        function dxCheckBoxRender(...) return dx:dxCheckBoxRender(...) end
    --[[ Label ]]--
        function dxCreateLabel(...) return dx:dxCreateLabel(getThisResource(),...) end
        function dxLabelGetScale(...) return dx:dxLabelGetScale(...) end
        function dxLabelGetHorizontalAlign(...) return dx:dxLabelGetHorizontalAlign(...) end
        function dxLabelGetVerticalAlign(...) return dx:dxLabelGetVerticalAlign(...) end
        function dxLabelSetScale(...) return dx:dxLabelSetScale(...) end
        function dxLabelSetHorizontalAlign(...) return dx:dxLabelSetHorizontalAlign(...) end
        function dxLabelSetVerticalAlign(...) return dx:dxLabelSetVerticalAlign(...) end
        function dxLabelRender(...) return dx:dxLabelRender(...) end
    --[[ Progressbar ]]--
        function dxCreateProgressBar(...) return dx:dxCreateProgressBar(getThisResource(),...) end
        function dxProgressBarGetProgress(...) return dx:dxProgressBarGetProgress(...) end
        function dxProgressBarGetProgressPercent(...) return dx:dxProgressBarGetProgressPercent(...) end
        function dxProgressBarGetMaxProgress(...) return dx:dxProgressBarGetMaxProgress(...) end
        function dxProgressBarSetProgress(...) return dx:dxProgressBarSetProgress(...) end
        function dxProgressBarSetProgressPercent(...) return dx:dxProgressBarSetProgressPercent(...) end
        function dxProgressBarSetMaxProgress(...) return dx:dxProgressBarSetMaxProgress(...) end
        function dxProgressBarRender(...) return dx:dxProgressBarRender(...) end
    --[[ Radio button ]]--
        function dxCreateRadioButton(...) return dx:dxCreateRadioButton(getThisResource(),...) end
        function dxRadioButtonGetSelected(...) return dx:dxRadioButtonGetSelected(...) end
        function dxRadioButtonGetGroup(...) return dx:dxRadioButtonGetGroup(...) end
        function dxRadioButtonSetSelected(...) return dx:dxRadioButtonSetSelected(...) end
        function dxRadioButtonSetGroup(...) return dx:dxRadioButtonSetGroup(...) end
        function dxRadioButtonRender(...) return dx:dxRadioButtonRender(...) end
    --[[ Scrollbar ]]--
        function dxCreateScrollBar(...) return dx:dxCreateScrollBar(getThisResource(),...) end
        function dxScrollBarGetProgress(...) return dx:dxScrollBarGetProgress(...) end
        function dxScrollBarGetProgressPercent(...) return dx:dxScrollBarGetProgressPercent(...) end
        function dxScrollBarGetMaxProgress(...) return dx:dxScrollBarGetMaxProgress(...) end
        function dxScrollBarSetProgress(...) return dx:dxScrollBarSetProgress(...) end
        function dxScrollBarSetProgressPercent(...) return dx:dxScrollBarSetProgressPercent(...) end
        function dxScrollBarSetMaxProgress(...) return dx:dxScrollBarSetMaxProgress(...) end
        function dxScrollBarRender(...) return dx:dxScrollBarRender(...) end
    --[[ Spinner ]]--
        function dxCreateSpinner(...) return dx:dxCreateSpinner(getThisResource(),...) end
        function dxSpinnerGetPosition(...) return dx:dxSpinnerGetPosition(...) end
        function dxSpinnerGetMin(...) return dx:dxSpinnerGetMin(...) end
        function dxSpinnerGetMin(...) return dx:dxSpinnerGetMin(...) end
        function dxSpinnerSetPosition(...) return dx:dxSpinnerSetPosition(...) end
        function dxSpinnerSetMin(...) return dx:dxSpinnerSetMin(...) end
        function dxSpinnerSetMin(...) return dx:dxSpinnerSetMin(...) end
        function dxSpinnerRender(...) return dx:dxSpinnerRender(...) end
    --[[ Static Image ]]--
        function dxCreateStaticImage(...) return dx:dxCreateStaticImage(getThisResource(),...) end
        function dxCreateStaticImageSection(...) return dx:dxCreateStaticImageSection(...) end
        function dxStaticImageGetLoadedImage(...) return dx:dxStaticImageGetLoadedImage(...) end
        function dxStaticImageGetSection(...) return dx:dxStaticImageGetSection(...) end
        function dxStaticImageGetRotation(...) return dx:dxStaticImageGetRotation(...) end
        function dxStaticImageLoadImage(...) return dx:dxStaticImageLoadImage(...) end
        function dxStaticImageSetSection(...) return dx:dxStaticImageSetSection(...) end
        function dxStaticImageSetRotation(...) return dx:dxStaticImageSetRotation(...) end
        function dxStaticImageRender(...) return dx:dxStaticImageRender(...) end
    --[[ Window ]]--
        function dxCreateWindow(...) return dx:dxCreateWindow(getThisResource(),...) end
        function dxWindowGetTitlePosition(...) return dx:dxWindowGetTitlePosition(...) end
        function dxWindowGetMovable(...) return dx:dxWindowGetMovable(...) end
        function dxWindowIsMoving(...) return dx:dxWindowIsMoving(...) end
        function dxWindowGetTitleVisible(...) return dx:dxWindowGetTitleVisible(...) end
        function dxWindowSetTitlePosition(...) return dx:dxWindowSetTitlePosition(...) end
        function dxWindowSetMovable(...) return dx:dxWindowSetMovable(...) end
        function dxWindowGetTitleVisible(...) return dx:dxWindowGetTitleVisible(...) end
        function dxWindowGetPostGUI(...) return dx:dxWindowGetPostGUI(...) end
        function dxWindowSetPostGUI(...) return dx:dxWindowSetPostGUI(...) end
        function dxWindowRender(...) return dx:dxWindowRender(...) end
        function dxWindowMoveControl(...) return dx:dxWindowMoveControl(...) end
        function dxWindowComponentRender(...) return dx:dxWindowComponentRender(...) end
    --[[ Listbox ]]--
        function dxCreateList(...) return dx:dxCreateList(getThisResource(),...) end
        function dxListClear(...) return dx:dxListClear(...) end
        function dxListGetSelectedItem(...) return dx:dxListGetSelectedItem(...) end
        function dxListSetSelectedItem(...) return dx:dxListSetSelectedItem(...) end
        function dxListGetItemCount(...) return dx:dxListGetItemCount(...) end
        function dxListRemoveRow(...) return dx:dxListRemoveRow(...) end
        function dxListAddRow(...) return dx:dxListAddRow(...) end
        function dxListSetTitleShow(...) return dx:dxListSetTitleShow(...) end
        function dxListGetTitleShow(...) return dx:dxListGetTitleShow(...) end
        function dxListRender(...) return dx:dxListRender(...) end
--[[ #Exports ]]--