////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright ${date} Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package com.cw.model.states{
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * class description: StopState
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0 
	 * author: christian
	 * created: Dec 24, 2011
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
	public class StopState implements IMusicPlayerState{
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var musicPlayerState:MusicPlayerState;
		private var currentTrack:String;
		private var currentTrackLoader:MP3Loader;
		private var forwardStepParam:int = 5;
		private var forwardLoopParam:Number = .5;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function StopState(musicPlayerState:MusicPlayerState){
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
		public function scrubber ():void {
			currentTrack = musicPlayerState.getCurrentTrack();
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.pauseSound();
		}
		public function stop():void{
			reset();
		}
		public function pause():void{
			reset();
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
			musicPlayerState.setState(musicPlayerState.getNext());
			reset();
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
			musicPlayerState.setState(musicPlayerState.getBack());
			reset();
		}
		public function forward ():void {
			currentTrack = musicPlayerState.getCurrentTrack();
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			if((currentTrackLoader.soundTime + forwardStepParam) > (currentTrackLoader.duration - (forwardStepParam + forwardLoopParam))) {
				currentTrackLoader.gotoSoundTime(0);
				currentTrackLoader.pauseSound();
				var theCurrentPosition:int = musicPlayerState.getCurrentPosition();
				musicPlayerState.setCurrentTrack(theCurrentPosition += 1);
				currentTrack = musicPlayerState.getCurrentTrack();
				currentTrackLoader = LoaderMax.getLoader(currentTrack);
				currentTrackLoader.playSound();
				reset();
				musicPlayerState.notifyObservers('thePlayStateOn');
			} else if((currentTrackLoader.soundTime + forwardStepParam) < currentTrackLoader.duration) {
				currentTrackLoader.playSound();
				currentTrackLoader.gotoSoundTime(currentTrackLoader.soundTime + forwardStepParam);
				musicPlayerState.setState(musicPlayerState.getForward());
				reset();
				musicPlayerState.notifyObservers('theForwardStateOn');
				TweenMax.delayedCall(forwardLoopParam, forward);
			}
		}
		public function rewind():void{
			reset();
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
			reset();
			currentTrackLoader.gotoSoundTime(0);
			currentTrackLoader.pauseSound();
			var theCurrentPosition:int = musicPlayerState.getCurrentPosition();
			musicPlayerState.setCurrentTrack(theCurrentPosition+=1);
			currentTrack = musicPlayerState.getCurrentTrack();
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			currentTrackLoader.playSound();
			musicPlayerState.setState(musicPlayerState.getPlay());
			currentTrackLoader.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			musicPlayerState.notifyObservers('thePlayStateOn');
		}
	}	
}