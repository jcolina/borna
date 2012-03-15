// ActionScript file
import Util.PopUpUtils;

import flash.events.MouseEvent;

import mx.events.EffectEvent;

/*

private var _objTextInput:TextInput;

public function set objTextInput(_objTextInput:TextInput):void{
	this._objTextInput = _objTextInput;
}

public function get objTextInput():TextInput{
	return this._objTextInput;
}

*/

private function initCom():void{
	/*
	this.x = this.objTextInput.x;
	this.y = this.objTextInput.y + this.objTextInput.height;
	*/
	
	this.x = PopUpUtils.x;
	this.y = PopUpUtils.y /* + PopUpUtils.objTextInput.height*/;
	//PopUpUtils.objTextInput.selectionBeginIndex(PopUpUtils.objTextInput.text.length);
	//PopUpUtils.objTextInput.selectionEndIndex = PopUpUtils.objTextInput.text.length;
	this.visible = true;
}

private function onClickButton(event:MouseEvent):void{
	PopUpUtils.objTextInput.text += event.currentTarget.label;
}

private function onClickButtonBorrar(event:MouseEvent):void{
	if(PopUpUtils.objTextInput.text != ""){
		PopUpUtils.objTextInput.text = PopUpUtils.objTextInput.text.substr(0, PopUpUtils.objTextInput.text.length - 1);
	}
}

private function closePopUp(event:EffectEvent):void{
	PopUpUtils.closePopUpTeclado();
}
