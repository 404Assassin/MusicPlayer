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
	 * class description: PlayState
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

	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class PlayState implements IMusicPlayerState {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var musicPlayerState:MusicPlayerState;
		private var currentTrack:String = 'track1';
		private var currentTrackLoader:MP3Loader;
		private var rewindStepParam:int = 5;
		private var rewindLoopParam:Number = .5;
		private var forwardStepParam:int = 5;
		private var forwardLoopParam:Number = .5;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function PlayState (musicPlayerState:MusicPlayerState) {
			this.musicPlayerState = musicPlayerState;
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function play ():void {
			trace(" ::::::::::: PlayState.play() ALREADY PLAYING");
		}
		public function stop ():void {
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
		public function pause ():void {
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
		public function next ():void {
		}
		public function back ():void {
		}
		public function forward ():void {
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			if((currentTrackLoader.soundTime + forwardStepParam) > (currentTrackLoader.duration - (forwardStepParam + forwardLoopParam))) {
				currentTrackLoader = LoaderMax.getLoader(currentTrack);
				currentTrackLoader.gotoSoundTime(currentTrackLoader.duration, false);
				musicPlayerState.notifyObservers('theStopStateOn');
				musicPlayerState.notifyObservers('thePlayStateOff');
				musicPlayerState.notifyObservers('thePauseStateOff');
				musicPlayerState.notifyObservers('theForwardStateOff');
				musicPlayerState.notifyObservers('theRewindStateOff');
				trace(" ::::::::::: PlayState.forward() end of the line!!!!!!!!");
				musicPlayerState.setState(musicPlayerState.getStop());
			} else if((currentTrackLoader.soundTime + forwardStepParam) < currentTrackLoader.duration) {
				trace(currentTrackLoader.soundTime + '\n' + currentTrackLoader.duration + forwardStepParam + forwardLoopParam);
				currentTrackLoader.gotoSoundTime(currentTrackLoader.soundTime + forwardStepParam);
				musicPlayerState.setState(musicPlayerState.getRewind());
				musicPlayerState.notifyObservers('theForwardStateOn');
				musicPlayerState.notifyObservers('theRewindStateOff');
				musicPlayerState.notifyObservers('thePlayStateOff');
				musicPlayerState.notifyObservers('thePauseStateOff');
				musicPlayerState.notifyObservers('theStopStateOff');
				TweenMax.delayedCall(forwardLoopParam, forward);
			}
		}
		/**
		 * Looping on rewind with TweenMax delayedCall call method so as
		 * to catch the audio queues on the rewind.
		 */
		public function rewind ():void {
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			if((currentTrackLoader.duration + rewindStepParam) < (rewindStepParam + rewindLoopParam)) {
				currentTrackLoader = LoaderMax.getLoader(currentTrack);
				currentTrackLoader.gotoSoundTime(0, true);
				musicPlayerState.setState(musicPlayerState.getPlay());
				musicPlayerState.notifyObservers('thePlayStateOn');
				musicPlayerState.notifyObservers('theStopStateOff');
				musicPlayerState.notifyObservers('thePauseStateOff');
				musicPlayerState.notifyObservers('theForwardStateOff');
				musicPlayerState.notifyObservers('theRewindStateOff');
			} else if((currentTrackLoader.soundTime + rewindStepParam) > 0) {
				trace(currentTrackLoader.soundTime + '\n' + currentTrackLoader.duration);
				currentTrackLoader.gotoSoundTime(currentTrackLoader.soundTime - rewindStepParam);
				musicPlayerState.setState(musicPlayerState.getRewind());
				musicPlayerState.notifyObservers('theRewindStateOn');
				musicPlayerState.notifyObservers('thePlayStateOff');
				musicPlayerState.notifyObservers('thePauseStateOff');
				musicPlayerState.notifyObservers('theStopStateOff');
				musicPlayerState.notifyObservers('theForwardStateOff');
				TweenMax.delayedCall(rewindLoopParam, rewind);
			}
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		/**
		 * Method for returning mp3 title text.
		 */
		private function theTitleText ():void {
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			var theMP3Title:String = currentTrackLoader.vars.mp3Title;
			trace(" ::::::::::: MusicPlayerState.theButtonText(nodeName) " + theMP3Title);
			trace(" ::::::::::: PlayState.rewind() " + '\n' + currentTrackLoader.soundTime + '\n' + currentTrackLoader.duration);
		}
	}
}
