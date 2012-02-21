////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright ${date} Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package com.cw.model.states {
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * class description: initialState
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: christian
	 * created: Dec 23, 2011
	 * TODO:
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import com.cw.model.MusicPlayerState;
	import com.greensock.TweenMax;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import flash.events.Event;
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class InitialState implements IMusicPlayerState {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var setInitialTrack:int = 1;
		private var musicPlayerState:MusicPlayerState;
		private var currentTrack:String;
		private var currentTrackLoader:MP3Loader;
		private var forwardStepParam:int = 5;
		private var forwardLoopParam:Number = .5;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function InitialState (musicPlayerState:MusicPlayerState) {
			this.musicPlayerState = musicPlayerState;
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function play ():void {
			musicPlayerState.setCurrentTrack(setInitialTrack);
			currentTrack = musicPlayerState.getCurrentTrack();
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.playSound();
			musicPlayerState.setState(musicPlayerState.getPlay());
			reset();
			currentTrackLoader.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			musicPlayerState.notifyObservers('thePlayStateOn');
		}
		public function scrubber ():void {
			currentTrack = musicPlayerState.getCurrentTrack();
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.pauseSound();
		}
		public function stop ():void {
			musicPlayerState.setCurrentTrack(setInitialTrack);
			musicPlayerState.setState(musicPlayerState.getStop());
			reset();
			musicPlayerState.notifyObservers('theStopState');
		}
		public function pause ():void {
			musicPlayerState.setCurrentTrack(setInitialTrack);
			musicPlayerState.setState(musicPlayerState.getPause());
			reset();
			musicPlayerState.notifyObservers('thePauseStateOn');
		}
		public function next ():void {
			musicPlayerState.setCurrentTrack(setInitialTrack);
			var theCurrentPosition:int = musicPlayerState.getCurrentPosition();
			musicPlayerState.setCurrentTrack(theCurrentPosition += 1);
			currentTrack = musicPlayerState.getCurrentTrack();
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			musicPlayerState.setState(musicPlayerState.getNext());
			currentTrackLoader.playSound();
			reset();
			musicPlayerState.notifyObservers('thePlayStateOn');
			currentTrackLoader.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		public function back ():void {
			musicPlayerState.setCurrentTrack(setInitialTrack);
			var theCurrentPosition:int = musicPlayerState.getCurrentPosition();
			musicPlayerState.setCurrentTrack(theCurrentPosition -= 1);
			currentTrack = musicPlayerState.getCurrentTrack();
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.playSound();
			musicPlayerState.setState(musicPlayerState.getPlay());
			reset();
			musicPlayerState.notifyObservers('thePlayStateOn');
			currentTrackLoader.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		public function forward ():void {
			musicPlayerState.setCurrentTrack(setInitialTrack);
			currentTrack = musicPlayerState.getCurrentTrack();
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			if((currentTrackLoader.soundTime + forwardStepParam) > (currentTrackLoader.duration - (forwardStepParam + forwardLoopParam))) {
				currentTrackLoader = LoaderMax.getLoader(currentTrack);
				currentTrackLoader.gotoSoundTime(currentTrackLoader.duration, false);
				musicPlayerState.setState(musicPlayerState.getStop());
				reset();
				currentTrackLoader.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			} else if((currentTrackLoader.soundTime + forwardStepParam) < currentTrackLoader.duration) {
				currentTrackLoader.playSound();
				currentTrackLoader.gotoSoundTime(currentTrackLoader.soundTime + forwardStepParam);
				musicPlayerState.setState(musicPlayerState.getForward());
				reset();
				musicPlayerState.notifyObservers('theForwardStateOn');
				TweenMax.delayedCall(forwardLoopParam, forward);
			}
		}
		public function rewind ():void {
			musicPlayerState.setCurrentTrack(setInitialTrack);
			musicPlayerState.notifyObservers('theRewindStateOff');
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private function reset ():void {
			TweenMax.killAll(false, false, true);
			musicPlayerState.notifyObservers('thePlayStateOff');
			musicPlayerState.notifyObservers('theForwardStateOff');
			musicPlayerState.notifyObservers('theRewindStateOff');
			musicPlayerState.notifyObservers('theNextStateOff');
			musicPlayerState.notifyObservers('theBackStateOff');
			musicPlayerState.notifyObservers('theStopStateOff');
			musicPlayerState.notifyObservers('thePauseStateOff');
		}
		private function onSoundComplete (event:Event):void {
			reset();
			currentTrackLoader.gotoSoundTime(0);
			currentTrackLoader.pauseSound();
			var theCurrentPosition:int = musicPlayerState.getCurrentPosition();
			musicPlayerState.setCurrentTrack(theCurrentPosition += 1);
			currentTrack = musicPlayerState.getCurrentTrack();
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.playSound();
			musicPlayerState.setState(musicPlayerState.getPlay());
			currentTrackLoader.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			musicPlayerState.notifyObservers('thePlayStateOn');
		}
	}
}