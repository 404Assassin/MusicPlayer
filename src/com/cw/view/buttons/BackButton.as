////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright 2012 Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package com.cw.view.buttons{
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * class description: BackButton
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0 
	 * author: christian
	 * created: Jan 11, 2012
	 * TODO:
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import com.cw.control.observer.IObserver;
	import com.cw.control.observer.ISubject;
	import com.cw.view.tweenStates.ButtonStates;
	import com.cw.view.tweenStates.ButtonOnOffStates;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class BackButton implements IButton, ISubject, IObserver{
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var observer:ISubject;
		private var theButton:Sprite
		private var buttonStates:ButtonStates = new ButtonStates();
		private var buttonOnOffStates:ButtonOnOffStates = new ButtonOnOffStates();
		private var theBackButton:bttn_back = new bttn_back();
		private var theButtonState:String;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function BackButton(){
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function setButton (theButtonState:String):void {
			this.theButtonState = theButtonState
			buttonBuild();
		}
		public function getButton ():Sprite {
			return theButton
		}
		/**
		 * InvokedObserver interface, reference update, and subscription with
		 * updated observer and adding subscription with addObserver(this).
		 */
		public function addObserver (observer:ISubject):void {
			this.observer = observer;
			observer.addObserver(this);
		}
		/**
		 * notify InvokedObservers
		 */
		public function notifyObservers (infoObject:String):void {
			observer.notifyObservers(infoObject);
		}
		/**
		 * remove an observer refrence from InvokedObserver
		 */
		public function removeObserver (observer:ISubject):void {
			observer.removeObserver(this);
		}
		/**
		 * receive notification from InvokedObserver
		 */
		public function update (infoObject:String):void {
			if(hasOwnProperty(infoObject)) {
				this[infoObject](infoObject);
			}
		}
		/**
		 * button on/off states via observer update
		 * @param infoObject
		 */	
		public function theBackStateOn (infoObject:String):void {
			buttonOnOffStates.buttonStatesInterface(theBackButton.iconTop, 'OnState');
		}
		public function theBackStateOff (infoObject:String):void {
			buttonOnOffStates.buttonStatesInterface(theBackButton.iconTop, 'OffState');
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private function buttonBuild ():void {
			theButton = new Sprite();
			theButton.addChild(theBackButton);
			addButtonEvents();
			theBackStateOff (null);
		}
		private function addButtonEvents ():void {
			theBackButton.buttonMode = true;
			theBackButton.doubleClickEnabled = true;
			theBackButton.addEventListener(MouseEvent.CLICK, placementTargetUp);
			theBackButton.addEventListener(MouseEvent.MOUSE_DOWN, placementTargetDown);
			theBackButton.addEventListener(MouseEvent.MOUSE_OUT, placementTargetOut);
			theBackButton.addEventListener(MouseEvent.MOUSE_OVER, placementTargetOver);
		}
		private function placementTargetOver (overEvent:Event):void {
			buttonStates.buttonStatesInterface(theBackButton.background, 'OverState');
			buttonStates.buttonStatesInterface(theBackButton.iconBottom, 'OverState');
		}
		private function placementTargetOut (outEvent:Event):void {
			buttonStates.buttonStatesInterface(theBackButton.background, 'OutState');
			buttonStates.buttonStatesInterface(theBackButton.iconBottom, 'OutState');
			buttonOnOffStates.buttonStatesInterface(theBackButton.iconMiddle, 'OffState');
		}
		private function placementTargetDown (downEvent:Event):void {
			trace(" ::::::::::: BackButton.placementTargetDown(downEvent) ");
			buttonStates.buttonStatesInterface(theBackButton.background, 'DownState');
			buttonStates.buttonStatesInterface(theBackButton.iconBottom, 'DownState');
			buttonOnOffStates.buttonStatesInterface(theBackButton.iconMiddle, 'OnState');
		}
		private function placementTargetUp (upEvent:Event):void {
			buttonStates.buttonStatesInterface(theBackButton.background, 'UpState');
			buttonOnOffStates.buttonStatesInterface(theBackButton.iconMiddle, 'OffState');
			notifyObservers(theButtonState);
		}
	}	
}