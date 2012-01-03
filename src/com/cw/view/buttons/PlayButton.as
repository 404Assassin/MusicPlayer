////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright 2012 Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package com.cw.view.buttons {
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * class description: PlayButton
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: christian
	 * created: Jan 2, 2012
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
	public class PlayButton implements IButton, ISubject {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var observer:ISubject;
		private var theButton:Sprite
		private var buttonStates:ButtonStates = new ButtonStates();
		private var thePlayButton:bttn_play = new bttn_play();
		private var theButtonState:String;
		private var theButtonBoolean:Boolean;
		private var theState:String = 'thePlayState';
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function PlayButton () {}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function setButton (theButtonState:String):void {
			this.theButtonState = theButtonState
			buttonBuild();
		}
		public function getButton ():Sprite {
			return theButton;
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
			theButton.addChild(thePlayButton);
			thePlayButton.x = 0;
			thePlayButton.y = 0;
			addButtonEvents();
		}
		private function addButtonEvents ():void {
			thePlayButton.buttonMode = true;
			thePlayButton.doubleClickEnabled = true;
			thePlayButton.addEventListener(MouseEvent.CLICK, placementTargetUp);
			thePlayButton.addEventListener(MouseEvent.MOUSE_DOWN, placementTargetDown);
			thePlayButton.addEventListener(MouseEvent.MOUSE_OUT, placementTargetOut);
			thePlayButton.addEventListener(MouseEvent.MOUSE_OVER, placementTargetOver);
		}
		private function placementTargetOver (overEvent:Event):void {
			buttonStates.buttonStatesInterface(thePlayButton.background, 'OverState');
			buttonStates.buttonStatesInterface(thePlayButton.icon, 'OverState');
		}
		private function placementTargetOut (outEvent:Event):void {
			buttonStates.buttonStatesInterface(thePlayButton.background, 'OutState');
			buttonStates.buttonStatesInterface(thePlayButton.icon, 'OutState');
		}
		private function placementTargetDown (downEvent:Event):void {
			buttonStates.buttonStatesInterface(thePlayButton.background, 'DownState');
			buttonStates.buttonStatesInterface(thePlayButton.icon, 'DownState');
		}
		private function placementTargetUp (upEvent:Event):void {
			buttonStates.buttonStatesInterface(thePlayButton.background, 'UpState');
			notifyObservers(theButtonState);
		}
		private function thePlayStateOn (infoObject:String):void {
			buttonStates.buttonStatesInterface(thePlayButton.iconTop, 'OnState');
		}
		private function thePlayStateOff (infoObject:String):void {
			buttonStates.buttonStatesInterface(thePlayButton.iconTop, 'OffState');
		}
	}
}
