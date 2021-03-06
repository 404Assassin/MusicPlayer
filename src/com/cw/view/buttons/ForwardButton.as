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
	 * class description: ForwardButton
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0 
	 * author: christian
	 * created: Jan 9, 2012
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
	public class ForwardButton implements IButton, ISubject, IObserver{
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var observer:ISubject;
		private var theButton:Sprite
		private var buttonStates:ButtonStates = new ButtonStates();
		private var buttonOnOffStates:ButtonOnOffStates = new ButtonOnOffStates();
		private var theForwardButton:bttn_forward = new bttn_forward();
		private var theButtonState:String;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function ForwardButton(){}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function setButton (theButtonState:String):void {
			this.theButtonState = theButtonState;
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
				this[infoObject]();
			}
		}
		/**
		 * button on/off states via observer update
		 * @param infoObject
		 */	
		public function theForwardStateOn ():void {
			buttonOnOffStates.buttonStatesInterface(theForwardButton.iconTop, 'OnState');
		}
		public function theForwardStateOff ():void {
			buttonOnOffStates.buttonStatesInterface(theForwardButton.iconTop, 'OffState');
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private function buttonBuild ():void {
			theButton = new Sprite();
			theButton.addChild(theForwardButton);
			addButtonEvents();
			theForwardStateOff ();
		}
		private function addButtonEvents ():void {
			theForwardButton.buttonMode = true;
			theForwardButton.doubleClickEnabled = true;
			theForwardButton.addEventListener(MouseEvent.CLICK, placementTargetUp);
			theForwardButton.addEventListener(MouseEvent.MOUSE_DOWN, placementTargetDown);
			theForwardButton.addEventListener(MouseEvent.MOUSE_OUT, placementTargetOut);
			theForwardButton.addEventListener(MouseEvent.MOUSE_OVER, placementTargetOver);
		}
		private function placementTargetOver (overEvent:Event):void {
			buttonStates.buttonStatesInterface(theForwardButton.background, 'OverState');
			buttonStates.buttonStatesInterface(theForwardButton.iconBottom, 'OverState');
		}
		private function placementTargetOut (outEvent:Event):void {
			buttonStates.buttonStatesInterface(theForwardButton.background, 'OutState');
			buttonStates.buttonStatesInterface(theForwardButton.iconBottom, 'OutState');
			buttonOnOffStates.buttonStatesInterface(theForwardButton.iconMiddle, 'OffState');
		}
		private function placementTargetDown (downEvent:Event):void {
			buttonStates.buttonStatesInterface(theForwardButton.background, 'DownState');
			buttonStates.buttonStatesInterface(theForwardButton.iconBottom, 'DownState');
			buttonOnOffStates.buttonStatesInterface(theForwardButton.iconMiddle, 'OnState');
		}
		private function placementTargetUp (upEvent:Event):void {
			buttonStates.buttonStatesInterface(theForwardButton.background, 'UpState');
			buttonOnOffStates.buttonStatesInterface(theForwardButton.iconMiddle, 'OffState');
			notifyObservers(theButtonState);
		}
	}	
}