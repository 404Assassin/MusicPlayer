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
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import com.greensock.TweenMax;
	import flash.events.Event;
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class ForwardState implements IMusicPlayerState{
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var musicPlayerState:MusicPlayerState;
		private var currentTrack:String;
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
			currentTrack = musicPlayerState.getCurrentTrack();
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.playSound();
			musicPlayerState.setState(musicPlayerState.getPlay());
			reset();
			musicPlayerState.notifyObservers('thePlayStateOn');
		}
		public function stop():void{
			currentTrack = musicPlayerState.getCurrentTrack();
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.gotoSoundTime(0);
			currentTrackLoader.pauseSound();
			musicPlayerState.setState(musicPlayerState.getStop());
			reset();
			musicPlayerState.notifyObservers('theStopState');
		}
		public function pause():void{
			currentTrack = musicPlayerState.getCurrentTrack();
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.pauseSound();
			musicPlayerState.setState(musicPlayerState.getPause());
			reset();
			musicPlayerState.notifyObservers('thePauseStateOn');
		}
		public function next ():void {
			currentTrack = musicPlayerState.getCurrentTrack();
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.gotoSoundTime(0);
			currentTrackLoader.pauseSound();
			var theCurrentPosition:int = musicPlayerState.getCurrentPosition();
			musicPlayerState.setCurrentTrack(theCurrentPosition+=1);
			currentTrack = musicPlayerState.getCurrentTrack();
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.playSound();
			musicPlayerState.setState(musicPlayerState.getPlay());
			reset();
			musicPlayerState.notifyObservers('thePlayStateOn');
		}
		public function back ():void {
			currentTrack = musicPlayerState.getCurrentTrack();
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.gotoSoundTime(0);
			currentTrackLoader.pauseSound();
			var theCurrentPosition:int = musicPlayerState.getCurrentPosition();
			musicPlayerState.setCurrentTrack(theCurrentPosition-=1);
			currentTrack = musicPlayerState.getCurrentTrack();
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.playSound();
			musicPlayerState.setState(musicPlayerState.getPlay());
			reset();
			musicPlayerState.notifyObservers('thePlayStateOn');
		}
		public function forward():void{
			currentTrack = musicPlayerState.getCurrentTrack();
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.playSound();
			musicPlayerState.setState(musicPlayerState.getPlay());
			reset();
			musicPlayerState.notifyObservers('thePlayStateOn');
		}
		public function rewind():void{
			currentTrack = musicPlayerState.getCurrentTrack();
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.playSound();
			musicPlayerState.setState(musicPlayerState.getPlay());
			reset();
			musicPlayerState.notifyObservers('thePlayStateOn');
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private function reset():void{
			TweenMax.killAll(false, false, true);
			musicPlayerState.notifyObservers('thePlayStateOff');
			musicPlayerState.notifyObservers('theForwardStateOff');
			musicPlayerState.notifyObservers('theRewindStateOff');
			musicPlayerState.notifyObservers('theNextStateOff');
			musicPlayerState.notifyObservers('theBackStateOff');
			musicPlayerState.notifyObservers('theStopStateOff');
			musicPlayerState.notifyObservers('thePauseStateOff');
		}
		private function onSoundComplete(event:Event):void{
			currentTrackLoader.gotoSoundTime(0);
			currentTrackLoader.pauseSound();
			var theCurrentPosition:int = musicPlayerState.getCurrentPosition();
			musicPlayerState.setCurrentTrack(theCurrentPosition+=1);
			currentTrack = musicPlayerState.getCurrentTrack();
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.playSound();
			musicPlayerState.setState(musicPlayerState.getPlay());
			currentTrackLoader.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			reset();
			musicPlayerState.notifyObservers('thePlayStateOn');
		}
	}	
}