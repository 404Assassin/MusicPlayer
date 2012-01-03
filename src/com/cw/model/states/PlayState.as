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
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class PlayState implements IMusicPlayerState{
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var musicPlayerState:MusicPlayerState;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function PlayState(musicPlayerState:MusicPlayerState)	{
			trace(" ::::::::::: PlayState.PlayState() " );
			this.musicPlayerState = musicPlayerState;
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function play():void{
			trace(" ::::::::::: PlayState.play() " + musicPlayerState);
			
		}
		public function stop():void{
			trace(" ::::::::::: PlayState.stop() " + musicPlayerState);
			musicPlayerState.setState(musicPlayerState.getStop());
			musicPlayerState.notifyObservers('theStopStateOn');
			musicPlayerState.notifyObservers('thePlayStateOff');
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