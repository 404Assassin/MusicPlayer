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
	 * class description: NextButton
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
	public class NextButton implements IButton, ISubject, IObserver{
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var observer:ISubject;
		private var theButton:Sprite
		private var buttonStates:ButtonStates = new ButtonStates();
		private var buttonOnOffStates:ButtonOnOffStates = new ButtonOnOffStates();
		private var theNextButton:bttn_next = new bttn_next();
		private var theButtonState:String;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function NextButton(){}
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
			trace(" ::::::::::: NextButton.notifyObservers(infoObject) "+infoObject);
			
			observer.notifyObservers(infoObject);
		}
		/**
		 * remove an observer refrence from InvokedObserver
		 */
		public function removeObserver (observer:ISubject):void {
//			observer.removeObserver(this);
		}
		/**
		 * receive notification from InvokedObserver
		 */
		public function update (infoObject:String):void {
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
			theButton.addChild(theNextButton);
			addButtonEvents();
			theNextStateOff (null);
		}
		private function addButtonEvents ():void {
			theNextButton.buttonMode = true;
//			theNextButton.doubleClickEnabled = true;
			theNextButton.addEventListener(MouseEvent.MOUSE_UP, placementTargetUp);
			theNextButton.addEventListener(MouseEvent.MOUSE_DOWN, placementTargetDown);
			theNextButton.addEventListener(MouseEvent.MOUSE_OUT, placementTargetOut);
			theNextButton.addEventListener(MouseEvent.MOUSE_OVER, placementTargetOver);
		}
		private function placementTargetOver (overEvent:Event):void {
			buttonStates.buttonStatesInterface(theNextButton.background, 'OverState');
			buttonStates.buttonStatesInterface(theNextButton.iconBottom, 'OverState');
		}
		private function placementTargetOut (outEvent:Event):void {
			buttonStates.buttonStatesInterface(theNextButton.background, 'OutState');
			buttonStates.buttonStatesInterface(theNextButton.iconBottom, 'OutState');
			buttonOnOffStates.buttonStatesInterface(theNextButton.iconMiddle, 'OffState');
		}
		private function placementTargetDown (downEvent:Event):void {
			trace(" ::::::::::: NextButton.placementTargetDown(downEvent) ");
			buttonStates.buttonStatesInterface(theNextButton.background, 'DownState');
			buttonStates.buttonStatesInterface(theNextButton.iconBottom, 'DownState');
			buttonOnOffStates.buttonStatesInterface(theNextButton.iconMiddle, 'OnState');
		}
		private function placementTargetUp (upEvent:Event):void {
			buttonStates.buttonStatesInterface(theNextButton.background, 'UpState');
			buttonOnOffStates.buttonStatesInterface(theNextButton.iconMiddle, 'OffState');
			notifyObservers(theButtonState);
			trace(" ::::::::::: NextButton.placementTargetUp(upEvent) "+theButtonState);
		}
		/**
		 * button on/off states via observer update
		 * @param infoObject
		 */	
		private function theNextStateOn (infoObject:String):void {
			trace(" ::::::::::: NextButton.theNextStateOn(infoObject) ");
			buttonOnOffStates.buttonStatesInterface(theNextButton.iconTop, 'OnState');
		}
		private function theNextStateOff (infoObject:String):void {
			buttonOnOffStates.buttonStatesInterface(theNextButton.iconTop, 'OffState');
		}
	}	
}