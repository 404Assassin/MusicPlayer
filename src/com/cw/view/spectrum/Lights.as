////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright 2012 Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package com.cw.view.spectrum {
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * class description: Lights a veriation on Adobe
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: christian
	 * created: Feb 2, 2012
	 * TODO:
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import com.greensock.TweenMax;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import org.casalib.util.StageReference;

	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class Lights {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var stageReference:Stage;
		private var theSprite:Sprite;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function Lights () {
			this.stageReference = StageReference.getStage();
			theSprite = new Sprite();
			stageReference.addChild(theSprite);
			TweenMax.to(theSprite, 1, {alpha:0});
			theSprite.x = 0;
			theSprite.y = 0
			stageReference.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private function onEnterFrame (event:Event):void {
			var waveWidth:int = 800;
			var waveHeight:int = 600;
			var bytes:ByteArray = new ByteArray();
			const PLOT_HEIGHT:int = 200;
			const CHANNEL_LENGTH:int = 256;
			SoundMixer.computeSpectrum(bytes, false, 0);
			var graphics:Sprite;
			var g:Graphics = theSprite.graphics;
			g.clear();
			g.beginFill(0x00B233);
			g.moveTo(0, PLOT_HEIGHT);
			var n:Number = 0;
			var i:int;
			for(i = 0; i < CHANNEL_LENGTH; i++) {
				n = (bytes.readFloat() * waveHeight);
				g.lineTo(i * (waveWidth / CHANNEL_LENGTH), PLOT_HEIGHT - n);
			}
			g.lineTo(waveWidth, PLOT_HEIGHT);
			g.endFill();
			g.beginFill(0xB20000, 0.5);
			g.moveTo(waveWidth, PLOT_HEIGHT);
			for(i = CHANNEL_LENGTH; i > 0; i--) {
				n = (bytes.readFloat() * waveHeight);
				g.lineTo(i * (waveWidth / CHANNEL_LENGTH), PLOT_HEIGHT - n);
			}
			g.lineTo(0, PLOT_HEIGHT);
			g.endFill();
			TweenMax.to(theSprite, .1, {alpha:1, blurFilter:{blurY:waveHeight}});
		}
		private function onPlaybackComplete (event:Event):void {
			stageReference.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	}
}