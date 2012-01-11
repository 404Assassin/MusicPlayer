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
	 * class description: RewindButton
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0 
	 * author: christian
	 * created: Jan 8, 2012
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
	public class RewindButton implements IButton, ISubject, IObserver {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var observer:ISubject;
		private var theButton:Sprite
		private var buttonStates:ButtonStates = new ButtonStates();
		private var buttonOnOffStates:ButtonOnOffStates = new ButtonOnOffStates();
		private var theRewindButton:bttn_rewind = new bttn_rewind();
		private var theButtonState:String;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function RewindButton(){}
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
			trace(" ::::::::::: RewindButton.notifyObservers(infoObject) "+infoObject);
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
			trace(" ::::::::::: RewindButton.update(infoObject) "+infoObject);
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
			theButton.addChild(theRewindButton);
			addButtonEvents();
		}
		private function addButtonEvents ():void {
			theRewindButton.buttonMode = true;
			theRewindButton.doubleClickEnabled = true;
			theRewindButton.addEventListener(MouseEvent.CLICK, placementTargetUp);
			theRewindButton.addEventListener(MouseEvent.MOUSE_DOWN, placementTargetDown);
			theRewindButton.addEventListener(MouseEvent.MOUSE_OUT, placementTargetOut);
			theRewindButton.addEventListener(MouseEvent.MOUSE_OVER, placementTargetOver);
		}
		private function placementTargetOver (overEvent:Event):void {
			buttonStates.buttonStatesInterface(theRewindButton.background, 'OverState');
			buttonStates.buttonStatesInterface(theRewindButton.iconBottom, 'OverState');
		}
		private function placementTargetOut (outEvent:Event):void {
			buttonStates.buttonStatesInterface(theRewindButton.background, 'OutState');
			buttonStates.buttonStatesInterface(theRewindButton.iconBottom, 'OutState');
			buttonOnOffStates.buttonStatesInterface(theRewindButton.iconMiddle, 'OffState');
		}
		private function placementTargetDown (downEvent:Event):void {
			buttonStates.buttonStatesInterface(theRewindButton.background, 'DownState');
			buttonStates.buttonStatesInterface(theRewindButton.iconBottom, 'DownState');
			buttonOnOffStates.buttonStatesInterface(theRewindButton.iconMiddle, 'OnState');
		}
		private function placementTargetUp (upEvent:Event):void {
			buttonStates.buttonStatesInterface(theRewindButton.background, 'UpState');
			buttonOnOffStates.buttonStatesInterface(theRewindButton.iconMiddle, 'OffState');
			notifyObservers(theButtonState);
		}
		/**
		 * button on/off states via observer update
		 * @param infoObject
		 */	
		private function theRewindStateOn (infoObject:String):void {
			buttonOnOffStates.buttonStatesInterface(theRewindButton.iconTop, 'OnState');
		}
		private function theRewindStateOff (infoObject:String):void {
			buttonOnOffStates.buttonStatesInterface(theRewindButton.iconTop, 'OffState');
		}
	}	
}