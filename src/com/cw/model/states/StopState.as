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
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class StopState implements IMusicPlayerState{
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var musicPlayerState:MusicPlayerState;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function StopState(musicPlayerState:MusicPlayerState){
			this.musicPlayerState = musicPlayerState;
			trace(" ::::::::::: StopState.StopState(musicPlayerState) ");
			
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function play():void{
			trace(" ::::::::::: StopState.play() " + musicPlayerState);
			musicPlayerState.setState(musicPlayerState.getPlay());
			musicPlayerState.notifyObservers('theStopStateOff');
			musicPlayerState.notifyObservers('thePlayStateOn');
		}
		public function stop():void{
			trace(" ::::::::::: StopState.stop() " + musicPlayerState);
		}
		public function pause():void{
		}
		public function next():void{
		}
		public function back():void{
		}
		public function forward():void{
		}
		public function rewind():void{
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	}	
}