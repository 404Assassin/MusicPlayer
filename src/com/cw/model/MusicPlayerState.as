////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright ${date} Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package com.cw.model {
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * class description: MusicPlayerState
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
	import com.cw.control.observer.IObserver;
	import com.cw.control.observer.ISubject;
	import com.cw.control.observer.InvokedObserver;
	import com.cw.model.states.IMusicPlayerState;
	import com.cw.model.states.ForwardState;
	import com.cw.model.states.InitialState;
	import com.cw.model.states.PlayState;
	import com.cw.model.states.PauseState;
	import com.cw.model.states.RewindState;
	import com.cw.model.states.StopState;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.XMLLoader;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.MP3Loader;
	import flash.events.Event;
	import flash.utils.Dictionary;
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class MusicPlayerState implements ISubject, IObserver {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var observer:ISubject;
		private var state:IMusicPlayerState;
		private var forwardState:IMusicPlayerState;
		private var initialState:IMusicPlayerState;
		private var pauseState:IMusicPlayerState;
		private var playState:IMusicPlayerState;
		private var rewindState:IMusicPlayerState;
		private var stopState:IMusicPlayerState;
		private var mp3Dictionary:Dictionary;
		private var currentTrack:String = 'track1';
		private var currentTrackLoader:MP3Loader;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function MusicPlayerState () {}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function initStateMachine ():void {
			forwardState = new ForwardState(this);
			initialState = new InitialState(this);
			pauseState = new PauseState(this);
			playState = new PlayState(this);
			stopState = new StopState(this);
			rewindState = new RewindState(this);
			setState(initialState);
//			theTitleText();
		}
		public function setState (state:IMusicPlayerState):void {
			trace(" ::::::::::: MusicPlayerState.setState(state) " + state);
			this.state = state;
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
//			trace(" ::::::::::: MusicPlayerState.notifyObservers(infoObject)infoObject.name " + infoObject);
			observer.notifyObservers(infoObject);
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
				trace(" ::::::::::: skip non methods!!!!! ");
			}
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// get Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function getInitial ():IMusicPlayerState {
			trace(" ::::::::::: MusicPlayerState.getInitial() ");
			return this.initialState;
		}
		public function getPlay ():IMusicPlayerState {
			trace(" ::::::::::: MusicPlayerState.getPlay() ");
			return this.playState;
		}
		public function getStop ():IMusicPlayerState {
			trace(" ::::::::::: MusicPlayerState.getStop() ");
			return this.stopState;
		}
		public function getPause ():IMusicPlayerState {
			trace(" ::::::::::: MusicPlayerState.getPause() ");
			return this.pauseState;
		}
//		public function getNext ():IMusicPlayerState {
//		}
//		public function getBack ():IMusicPlayerState {
//		}
		public function getForward ():IMusicPlayerState {
			trace(" ::::::::::: MusicPlayerState.getForward() ");
			return this.forwardState;
		}
		public function getRewind ():IMusicPlayerState {
			trace(" ::::::::::: MusicPlayerState.getRewind() ");
			return this.rewindState;
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private function play ():void {
			state.play();
		}
		private function stop ():void {
			state.stop();
		}
		private function pause ():void {
			state.pause();
		}
		private function next ():void {
		}
		private function back ():void {
		}
		private function forward ():void {
			state.forward();
		}
		private function rewind ():void {
			state.rewind();
		}
		/**
		 * Method for returning mp3 title text.
		 */
		private function theTitleText ():void {
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			var theMP3Title:String = currentTrackLoader.vars.mp3Title;
			trace(" ::::::::::: MusicPlayerState.theButtonText(nodeName) " + theMP3Title + '\n' + currentTrackLoader.soundTime + '\n' + currentTrackLoader.duration);
		}
	}
}
