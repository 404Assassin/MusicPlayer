////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright ${date} Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package com.cw.view.buttons {
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * class description: StopButton
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: christian
	 * created: Dec 26, 2011
	 * TODO:
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import com.cw.control.observer.ISubject;
	import com.cw.view.tweenStates.ButtonStates;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class StopButton implements IButton, ISubject {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var observer:ISubject;
		private var theButton:Sprite
		private var buttonStates:ButtonStates = new ButtonStates();
		private var theStopButton:bttn_stop = new bttn_stop();
		private var theButtonState:String;
		private var theButtonBoolean:Boolean;
//		private var theState:String = 'theStopState';
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function StopButton () {}
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
		public function update (observer:ISubject, infoObject:String):void {
			try {
				this[infoObject](infoObject);
			} catch(error:Error) {
				trace(" ::::::::::: skip non methods!!!!! ");
			}
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private function buttonBuild ():void {
			theButton = new Sprite();
			theButton.addChild(theStopButton);
			theStopButton.x = 0;
			theStopButton.y = 0;
			addButtonEvents();
		}
		private function addButtonEvents ():void {
			theStopButton.buttonMode = true;
			theStopButton.doubleClickEnabled = true;
			theStopButton.addEventListener(MouseEvent.CLICK, placementTargetUp);
			theStopButton.addEventListener(MouseEvent.MOUSE_DOWN, placementTargetDown);
			theStopButton.addEventListener(MouseEvent.MOUSE_OUT, placementTargetOut);
			theStopButton.addEventListener(MouseEvent.MOUSE_OVER, placementTargetOver);
		}
		private function placementTargetOver (overEvent:Event):void {
			buttonStates.buttonStatesInterface(theStopButton.background, 'OverState');
			buttonStates.buttonStatesInterface(theStopButton.icon, 'OverState');
		}
		private function placementTargetOut (outEvent:Event):void {
			buttonStates.buttonStatesInterface(theStopButton.background, 'OutState');
			buttonStates.buttonStatesInterface(theStopButton.icon, 'OutState');
		}
		private function placementTargetDown (downEvent:Event):void {
			buttonStates.buttonStatesInterface(theStopButton.background, 'DownState');
			buttonStates.buttonStatesInterface(theStopButton.icon, 'DownState');
		}
		private function placementTargetUp (upEvent:Event):void {
			buttonStates.buttonStatesInterface(theStopButton.background, 'UpState');
			notifyObservers(theButtonState);
		}
		private function theStopStateOn (infoObject:String):void {
			buttonStates.buttonStatesInterface(theStopButton.iconTop, 'OnState');
		}
		private function theStopStateOff (infoObject:String):void {
			buttonStates.buttonStatesInterface(theStopButton.iconTop, 'OffState');
		}
	}
}