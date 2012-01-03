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
	import com.cw.model.states.InitialState;
	import com.cw.model.states.PlayState;
	import com.cw.model.states.StopState;

	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class MusicPlayerState implements ISubject {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var observer:ISubject;
		private var state:IMusicPlayerState;
		private var initialState:IMusicPlayerState;
		private var stopState:IMusicPlayerState;
		private var playState:IMusicPlayerState;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function MusicPlayerState () {}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function initStateMachine ():void {
			initialState = new InitialState(this);
			stopState = new StopState(this);
			playState = new PlayState(this);
			this.state = initialState;
		}
		public function setState (state:IMusicPlayerState):void {
			this.state = state;
//			notifyObservers(theState);
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
			trace(" ::::::::::: MusicPlayerState.notifyObservers(infoObject)infoObject.name "+infoObject);
			
			observer.notifyObservers(infoObject);
		}
		/**
		 * remove an observer refrence from InvokedObserver
		 */
		public function removeObserver (observer:ISubject):void {
		}
		public function update (observer:ISubject, infoObject:String):void {
			try{
				trace(" ::::::::::: MusicPlayerState.update(observer, infoObject) we are on");
				
				this[infoObject]();
			} catch (error:Error) {
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
//			notifyObservers('thePlayState');
			return this.playState;
		}
		public function getStop ():IMusicPlayerState {
			trace(" ::::::::::: MusicPlayerState.getStop() ");
//			notifyObservers('theStopState');
			return this.stopState;
		}
//		public function getPause ():IMusicPlayerState {
//		}
//		public function getNext ():IMusicPlayerState {
//		}
//		public function getBack ():IMusicPlayerState {
//		}
//		public function getForward ():IMusicPlayerState {
//		}
//		public function getRewind ():IMusicPlayerState {
//		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private function play ():void {
			trace(" ::::::::::: MusicPlayerState.play() " + state);
			state.play();
		}
		private function stop ():void {
			trace(" ::::::::::: MusicPlayerState.stop() " + state);
			state.stop();
		}
		private function pause ():void {
		}
		private function next ():void {
		}
		private function back ():void {
		}
		private function forward ():void {
		}
		private function rewind ():void {
		}
	}
}