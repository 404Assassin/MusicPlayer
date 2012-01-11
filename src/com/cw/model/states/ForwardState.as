////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright 2012 Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package com.cw.model.states{
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * class description: ForwardState
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
	import com.cw.model.MusicPlayerState;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import com.greensock.TweenMax;
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class ForwardState implements IMusicPlayerState{
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var musicPlayerState:MusicPlayerState;
		private var currentTrack:String = 'track1';
		private var currentTrackLoader:MP3Loader;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function ForwardState(musicPlayerState:MusicPlayerState){
			this.musicPlayerState = musicPlayerState;
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function play():void{
			TweenMax.killAll(false, false, true);
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.playSound();
			musicPlayerState.setState(musicPlayerState.getPlay());
			musicPlayerState.notifyObservers('thePlayStateOn');
			musicPlayerState.notifyObservers('theStopStateOff');
			musicPlayerState.notifyObservers('thePauseStateOff');
			musicPlayerState.notifyObservers('theForwardStateOff');
			musicPlayerState.notifyObservers('theRewindStateOff');
		}
		public function stop():void{
			TweenMax.killAll(false, false, true);
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.gotoSoundTime(0);
			currentTrackLoader.pauseSound();
			musicPlayerState.setState(musicPlayerState.getStop());
			musicPlayerState.notifyObservers('theStopStateOff');
			musicPlayerState.notifyObservers('thePlayStateOff');
			musicPlayerState.notifyObservers('thePauseStateOff');
			musicPlayerState.notifyObservers('theForwardStateOff');
			musicPlayerState.notifyObservers('theRewindStateOff');
		}
		public function pause():void{
			TweenMax.killAll(false, false, true);
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.pauseSound();
			musicPlayerState.setState(musicPlayerState.getPause());
			musicPlayerState.notifyObservers('thePauseStateOn');
			musicPlayerState.notifyObservers('thePlayStateOff');
			musicPlayerState.notifyObservers('theForwardStateOff');
			musicPlayerState.notifyObservers('theRewindStateOff');
			musicPlayerState.notifyObservers('theStopStateOff');
		}
		public function next():void{
		}
		public function back():void{
		}
		public function forward():void{
			TweenMax.killAll(false, false, true);
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.playSound();
			musicPlayerState.setState(musicPlayerState.getPlay());
			musicPlayerState.notifyObservers('thePlayStateOn');
			musicPlayerState.notifyObservers('theStopStateOff');
			musicPlayerState.notifyObservers('thePauseStateOff');
			musicPlayerState.notifyObservers('theForwardStateOff');
			musicPlayerState.notifyObservers('theRewindStateOff');
		}
		public function rewind():void{
			TweenMax.killAll(false, false, true);
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.playSound();
			musicPlayerState.setState(musicPlayerState.getPlay());
			musicPlayerState.notifyObservers('thePlayStateOn');
			musicPlayerState.notifyObservers('theStopStateOff');
			musicPlayerState.notifyObservers('thePauseStateOff');
			musicPlayerState.notifyObservers('theForwardStateOff');
			musicPlayerState.notifyObservers('theRewindStateOff');
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		/**
		 * Method for returning mp3 title text.
		 */
		private function theTitleText ():void {
			var theMP3Title:String = currentTrackLoader.vars.mp3Title;
			trace(" ::::::::::: MusicPlayerState.theButtonText(nodeName) " + theMP3Title);
			trace(" ::::::::::: PlayState.rewind() " + '\n' + currentTrackLoader.soundTime + '\n' + currentTrackLoader.duration);
		}
	}	
}