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
	import com.cw.model.states.BackState;
	import com.cw.model.states.ForwardState;
	import com.cw.model.states.IMusicPlayerState;
	import com.cw.model.states.InitialState;
	import com.cw.model.states.NextState;
	import com.cw.model.states.PauseState;
	import com.cw.model.states.PlayState;
	import com.cw.model.states.RewindState;
	import com.cw.model.states.ScrubberState;
	import com.cw.model.states.StopState;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
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
		private var nextState:IMusicPlayerState;
		private var backState:IMusicPlayerState;
		private var forwardState:IMusicPlayerState;
		private var initialState:IMusicPlayerState;
		private var pauseState:IMusicPlayerState;
		private var playState:IMusicPlayerState;
		private var rewindState:IMusicPlayerState;
		private var scrubberState:IMusicPlayerState;
		private var stopState:IMusicPlayerState;
		private var currentPosition:int;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function MusicPlayerState () {}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function initStateMachine ():void {
			forwardState = new ForwardState(this);
			nextState = new NextState(this);
			backState = new BackState(this);
			initialState = new InitialState(this);
			pauseState = new PauseState(this);
			scrubberState = new ScrubberState(this);
			playState = new PlayState(this);
			stopState = new StopState(this);
			rewindState = new RewindState(this);
			setState(initialState);
		}
		public function setState (state:IMusicPlayerState):void {
			this.state = state;
		}
		public function getCurrentPosition():int{
			this.currentPosition = currentPosition;
			return currentPosition
		}
		public function setCurrentTrack(currentPosition:int):void{
			this.currentPosition = currentPosition;
			var xmlQueue:LoaderMax = LoaderMax.getLoader("mp3Queue");
			var xmlArray:Array = xmlQueue.content;
			if(currentPosition > xmlArray.length){
				this.currentPosition = 1;
			}
			if(currentPosition < 1){
				this.currentPosition = xmlArray.length;
			}
		}
		public function getCurrentTrack():String{
			var currentTrack:String;
			currentTrack = 'track' + currentPosition;
			notifyObservers(currentTrack);
			return currentTrack
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
//				trace(" ::::::::::: skip non methods!!!!! ");
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
		public function getScrubber ():IMusicPlayerState {
			trace(" ::::::::::: MusicPlayerState.getScrubber() ");
			return this.scrubberState;
		}
		public function getStop ():IMusicPlayerState {
			trace(" ::::::::::: MusicPlayerState.getStop() ");
			return this.stopState;
		}
		public function getPause ():IMusicPlayerState {
			trace(" ::::::::::: MusicPlayerState.getPause() ");
			return this.pauseState;
		}
		public function getNext ():IMusicPlayerState {
			trace(" ::::::::::: MusicPlayerState.getNext() ");
			return this.nextState;
		}
		public function getBack ():IMusicPlayerState {
			trace(" ::::::::::: MusicPlayerState.getBack() ");
			return this.backState;
		}
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
		private function scrubber ():void {
			state.scrubber();
		}
		private function next ():void {
			state.next();
		}
		private function back ():void {
			state.back();
		}
		private function forward ():void {
			state.forward();
		}
		private function rewind ():void {
			state.rewind();
		}
	}
}
