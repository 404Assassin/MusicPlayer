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
	import com.cw.control.observer.ISubject;
	import com.cw.model.MusicPlayerState;
	import com.cw.view.SpectrumDisplay;
	import com.cw.view.buttons.BackButton;
	import com.cw.view.buttons.ForwardButton;
	import com.cw.view.buttons.NextButton;
	import com.cw.view.buttons.PauseButton;
	import com.cw.view.buttons.PlayButton;
	import com.cw.view.buttons.RewindButton;
	import com.cw.view.buttons.StopButton;
	import com.cw.view.interfaceElements.ProgressIndicator;
	import com.cw.view.interfaceElements.VolumeController;
	import com.cw.view.preloaders.OneBarPreloader;
	import com.cw.view.spectrum.Lights;
	import com.cw.view.text.CDynamicTextField;
	import com.cw.view.text.TitleText;
	import com.greensock.TweenMax;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import flash.display.Sprite;
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class MusicPlayerUI implements ISubject {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var observer:ISubject;
		private var theMusicPlayerUI:Sprite
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
			return theMusicPlayerUI;
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
			this.observer = observer;
			observer.removeObserver(this);
		}
		public function update (infoObject:String):void {
			if(hasOwnProperty(infoObject)) {
				this[infoObject]();
			}
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private function addInterface ():void {
			theMusicPlayerUI = new Sprite();
			theMusicPlayerUI.addChild(buttonHolder);
			specTest();
			preloader();
			titleText(theMusicPlayerUI);
			rewindButton(theMusicPlayerUI);
			backButton(theMusicPlayerUI);
			stopButton(theMusicPlayerUI);
			pauseButton(theMusicPlayerUI);
			playButton(theMusicPlayerUI);
			nextButton(theMusicPlayerUI);
			forwardButton(theMusicPlayerUI);
			scrubber();
			volumeController();
		}
		private function specTest():void{
			var theLights:Lights = new Lights();
			
		}
		/**
		 * Method for creating and returning the preloader.
		 */
		private function preloader ():void {
			var theOneBarPreloader:OneBarPreloader = new OneBarPreloader();
			theOneBarPreloader.addObserver(observer);
			theOneBarPreloader.initProgressBar();
			var preloadBar:Sprite = theOneBarPreloader.getProgressBar();
			theMusicPlayerUI.addChild(preloadBar);
			preloadBar.x = 171;
			preloadBar.y = 140;
		}
		/**
		 * Method for creating and returning the scrubber and play progress view.
		 */
		private function scrubber():void{
			var theProgressIndicator:ProgressIndicator = new ProgressIndicator();
			theProgressIndicator.addObserver(observer);
			theProgressIndicator.initProgressBar();
			var preloadBar:Sprite = theProgressIndicator.getProgressBar();
			theMusicPlayerUI.addChild(preloadBar);
			preloadBar.x = 171;
			preloadBar.y = 140;
		}
		/**
		 * Methods for creating and returning the player buttons.
		 */
		private function rewindButton (theMusicPlayerUI:Sprite):void {
			var theRewindButton:RewindButton = new RewindButton();
			theRewindButton.addObserver(observer);
			theRewindButton.setButton('rewind');
			var rewindButton:Sprite = theRewindButton.getButton();
			buttonHolder.addChild(rewindButton);
			rewindButton.x = 12;
			rewindButton.y = 150;
		}
		private function backButton (theMusicPlayerUI:Sprite):void {
			var theBackButton:BackButton = new BackButton();
			theBackButton.addObserver(observer);
			theBackButton.setButton('back');
			var backButton:Sprite = theBackButton.getButton();
			buttonHolder.addChild(backButton);
			backButton.x = 36;
			backButton.y = 150;
		}
		private function stopButton (theMusicPlayerUI:Sprite):void {
			var theStopButton:StopButton = new StopButton();
			theStopButton.addObserver(observer);
			theStopButton.setButton('stop');
			var stopButton:Sprite = theStopButton.getButton();
			buttonHolder.addChild(stopButton);
			stopButton.x = 60;
			stopButton.y = 150;
		}
		private function pauseButton (theMusicPlayerUI:Sprite):void {
			var thePauseButton:PauseButton = new PauseButton();
			thePauseButton.addObserver(observer);
			thePauseButton.setButton('pause');
			var pauseButton:Sprite = thePauseButton.getButton();
			buttonHolder.addChild(pauseButton);
			pauseButton.x = 84;
			pauseButton.y = 150;
		}
		private function playButton (theMusicPlayerUI:Sprite):void {
			var thePlayButton:PlayButton = new PlayButton();
			thePlayButton.addObserver(observer);
			thePlayButton.setButton('play');
			var playButton:Sprite = thePlayButton.getButton();
			buttonHolder.addChild(playButton);
			playButton.x = 108;
			playButton.y = 150;
		}
		private function nextButton (theMusicPlayerUI:Sprite):void {
			var theNextButton:NextButton = new NextButton();
			theNextButton.addObserver(observer);
			theNextButton.setButton('next');
			var nextButton:Sprite = theNextButton.getButton();
			buttonHolder.addChild(nextButton);
			nextButton.x = 132;
			nextButton.y = 150;
		}
		private function forwardButton (theMusicPlayerUI:Sprite):void {
			var theForwardButton:ForwardButton = new ForwardButton();
			theForwardButton.addObserver(observer);
			theForwardButton.setButton('forward');
			var forwardButton:Sprite = theForwardButton.getButton();
			buttonHolder.addChild(forwardButton);
			forwardButton.x = 156;
			forwardButton.y = 150;
		}
		/**
		 * Method for creating and returning the mp3 title text field.
		 */
		private function titleText (theMusicPlayerUI:Sprite):void {
			var theTitleText:TitleText = new TitleText()
			theTitleText.addObserver(observer);
			theTitleText.initTheTitleText();
			var titleText:Sprite = theTitleText.getTheTitleText()
			buttonHolder.addChild(titleText);
			titleText.x = 170;
			titleText.y = 139;
		}
		/**
		 * Method for creating and returning the mp3 volume controller.
		 */
		private function volumeController():void{
			var theVolumeController:VolumeController = new VolumeController();
			theVolumeController.addObserver(observer);
			theVolumeController.initVolumeController();
			var volumeController:Sprite = theVolumeController.getVolumeController()
			theMusicPlayerUI.addChild(volumeController);
			volumeController.x = 475;
			volumeController.y = 139;
		}
	}
}
