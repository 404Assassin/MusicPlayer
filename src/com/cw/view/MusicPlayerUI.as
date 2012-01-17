////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright ${date} Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package com.cw.view {
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	/**
	 * class description: MusicPlayerInterface
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: christian
	 * created: Dec 23, 2011
	 * TODO:
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import com.cw.control.observer.IObserver;
	import com.cw.control.observer.ISubject;
	import com.cw.control.observer.InvokedObserver;
	import com.cw.model.MusicPlayerState;
	import com.cw.view.buttons.BackButton;
	import com.cw.view.buttons.ForwardButton;
	import com.cw.view.buttons.NextButton;
	import com.cw.view.buttons.PauseButton;
	import com.cw.view.buttons.PlayButton;
	import com.cw.view.buttons.RewindButton;
	import com.cw.view.buttons.StopButton;
	import com.cw.view.text.CDynamicTextField;
	import com.cw.view.text.ICDynamicTextField;
	import com.cw.view.tweenStates.ButtonStates;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class MusicPlayerUI implements ISubject {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var observer:ISubject;
		private var theMusicPlayerUI:Sprite
		private var theMusicPlayer:musicPlayerInterface = new musicPlayerInterface();
		private var theBackButton:bttn_back = new bttn_back();
		private var theForwardButton:bttn_forward = new bttn_forward();
		private var theRewindButton:bttn_rewind = new bttn_rewind();
		private var theStopButton:bttn_stop = new bttn_stop();
		private var thePauseButton:bttn_pause = new bttn_pause();
		private var thePlayButton:bttn_play = new bttn_play();
		private var theNextButton:bttn_next = new bttn_next();
		private var theCDynamicTextField:CDynamicTextField;
		private var theButtonState:String;
		private var buttonHolder:Sprite = new Sprite();
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function MusicPlayerUI () {}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function buildMusicPlayerUI ():void {
			addInterface();
		}
		public function getMusicPlayerUI ():Sprite {
			return theMusicPlayerUI
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
		 * InvokedObserver notification
		 */
		public function notifyObservers (infoObject:String):void {
			observer.notifyObservers(theButtonState);
		}
		/**
		 * remove an observer refrence from InvokedObserver
		 */
		public function removeObserver (observer:ISubject):void {
		}
		public function update (infoObject:String):void {
			try {
				this[infoObject]();
			} catch(error:Error) {
				//trace(" ::::::::::: skip non methods!!!!! ");
			}
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private function addInterface ():void {
			theMusicPlayerUI = new Sprite();
			theMusicPlayerUI.addChild(theMusicPlayer);
			rewindButton(theMusicPlayerUI);
			backButton(theMusicPlayerUI);
			stopButton(theMusicPlayerUI);
			pauseButton(theMusicPlayerUI);
			playButton(theMusicPlayerUI);
			nextButton(theMusicPlayerUI);
			forwardButton(theMusicPlayerUI);
			titleText ('the title text');
		}
		private function rewindButton (theMusicPlayerUI:Sprite):void {
			theMusicPlayerUI.addChild(buttonHolder);
			var theRewindButton:RewindButton = new RewindButton();
			theRewindButton.addObserver(observer);
			theRewindButton.setButton('rewind');
			var rewindButton:Sprite = theRewindButton.getButton();
			buttonHolder.addChild(rewindButton);
			rewindButton.x = 12;
			rewindButton.y = 150;
		}
		private function backButton (theMusicPlayerUI:Sprite):void {
			theMusicPlayerUI.addChild(buttonHolder);
			var theBackButton:BackButton = new BackButton();
			theBackButton.addObserver(observer);
			theBackButton.setButton('back');
			var backButton:Sprite = theBackButton.getButton();
			buttonHolder.addChild(backButton);
			backButton.x = 36;
			backButton.y = 150;
		}
		private function stopButton (theMusicPlayerUI:Sprite):void {
			theMusicPlayerUI.addChild(buttonHolder);
			var theStopButton:StopButton = new StopButton();
			theStopButton.addObserver(observer);
			theStopButton.setButton('stop');
			var stopButton:Sprite = theStopButton.getButton();
			buttonHolder.addChild(stopButton);
			stopButton.x = 60;
			stopButton.y = 150;
		}
		private function pauseButton (theMusicPlayerUI:Sprite):void {
			theMusicPlayerUI.addChild(buttonHolder);
			var thePauseButton:PauseButton = new PauseButton();
			thePauseButton.addObserver(observer);
			thePauseButton.setButton('pause');
			var pauseButton:Sprite = thePauseButton.getButton();
			buttonHolder.addChild(pauseButton);
			pauseButton.x = 84;
			pauseButton.y = 150;
		}
		private function playButton (theMusicPlayerUI:Sprite):void {
			theMusicPlayerUI.addChild(buttonHolder);
			var thePlayButton:PlayButton = new PlayButton();
			thePlayButton.addObserver(observer);
			thePlayButton.setButton('play');
			var playButton:Sprite = thePlayButton.getButton();
			buttonHolder.addChild(playButton);
			playButton.x = 108;
			playButton.y = 150;
		}
		private function nextButton (theMusicPlayerUI:Sprite):void {
			theMusicPlayerUI.addChild(buttonHolder);
			var theNextButton:NextButton = new NextButton();
			theNextButton.addObserver(observer);
			theNextButton.setButton('next');
			var nextButton:Sprite = theNextButton.getButton();
			buttonHolder.addChild(nextButton);
			nextButton.x = 132;
			nextButton.y = 150;
		}
		private function forwardButton (theMusicPlayerUI:Sprite):void {
			theMusicPlayerUI.addChild(buttonHolder);
			var theForwardButton:ForwardButton = new ForwardButton();
			theForwardButton.addObserver(observer);
			theForwardButton.setButton('forward');
			var forwardButton:Sprite = theForwardButton.getButton();
			buttonHolder.addChild(forwardButton);
			forwardButton.x = 156;
			forwardButton.y = 150;
		}
		private function titleText (theTitleText:String):void {
			theCDynamicTextField = new CDynamicTextField();
			theCDynamicTextField.textFieldInterface(theTitleText, 300, 22, false, 0xffffff, false, false);
			var theTextField:Sprite = theCDynamicTextField.getTheTextField();
			theMusicPlayerUI.addChild(theTextField);
			theTextField.x = 170;
			theTextField.y = 139;
		}
	}
}
