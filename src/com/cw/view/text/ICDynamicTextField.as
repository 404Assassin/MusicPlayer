package com.cw.view.text{
	/**
	 * ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * interface description: ICDynamicTextField
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0 
	 * author: christian
	 * created: Dec 4, 2011
	 * TODO:
	 * ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import flash.display.Sprite;
	//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Interface characteristics
	//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public interface ICDynamicTextField{
		//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		function textFieldInterface(textContent:String, textFieldWidth:uint, textFieldHeight:uint, textFieldBackground:Boolean, textFieldBackgroundColor:uint, textFieldMultiline:Boolean, textFieldWordWrap:Boolean):void;
		function getTheTextField():Sprite;
	}
}