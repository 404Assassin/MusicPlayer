////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright 2012 Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package com.cw.view.progressUI {
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * class description: ProgressIndicator
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: christian
	 * created: Jan 23, 2012
	 * TODO:
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import com.cw.control.observer.ISubject;
	import com.cw.utilities.math.DiagonalValue;
	import com.cw.view.shapeCreators.CreateShape;
	import com.greensock.TimelineLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import flash.display.Sprite;
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class ProgressIndicator implements ISubject {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var progressBarHolder:Sprite;
		private var progressBar:Sprite;
		private var progressBarHeight:int = 20;
		private var progressBarWidth:int = 298;
		private var scrubberSymbol:Sprite;
		private var observer:ISubject;
		private var currentTrack:String;
		private var currentTrackLoader:MP3Loader;
		private var currentPosition:String;
		private var myTimeline:TimelineLite;
		private var theStateOfPlay:Boolean;
		private var diagonal:Number;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function ProgressIndicator () {}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function initProgressBar ():void {
			addProgressBarHolder();
			addProgressScrubber ();
		}
		public function getProgressBar ():Sprite {
			return progressBarHolder;
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
			this.observer = observer;
			observer.removeObserver(this);
		}
		/**
		 * Updates to all registared observers with string @param infoObject.
		 */		
		public function update (infoObject:String):void {
			if(infoObject.substring(0, 5) == 'track') {
				this.currentTrack = infoObject;
			}
			if(hasOwnProperty(infoObject)) {
				this[infoObject]();
			}
		}
		/**
		 * Update call from controller to first check if the sound is playing 
		 * and if it's not play the progress loop.
		 */		
		public function thePlayStateOn ():void {
			if(!theStateOfPlay) {
				theStateOfPlay = true;
				progressHandler();
			}
		}
		/**
		 * Update call from controller to pause the progress loop.
		 */		
		public function thePauseStateOn ():void {
			theStateOfPlay = false
			myTimeline.pause();
		}
		/**
		 * Update call from controller to pause the progress loop and reset the 
		 * state of both the scrubber symbol and the progress bar.
		 */		
		public function theStopState ():void {
			theStateOfPlay = false
			TweenMax.to(scrubberSymbol, .2, {alpha:.25, x:(0-(diagonal*.5)-.5), ease:Linear});
			TweenMax.to(progressBar, .2, {alpha:.25, scaleX:0, ease:Linear});
			myTimeline.stop();
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		/**
		 * Create and add progress bar holder sprite which will act as our 
		 * returned Object. Next create and add a mask for all included objects.
		 */		
		private function addProgressBarHolder ():void {
			progressBarHolder = new Sprite();
			var scrubberSymbolMask:Sprite = new Sprite();
			progressBarHolder.addChild(scrubberSymbolMask);
			var theShapeCreator:CreateShape = new CreateShape();
			theShapeCreator.draw(CreateShape.SQUARE_FILLED, scrubberSymbolMask, 0, 0, progressBarWidth, progressBarHeight);
			progressBarHolder.mask = scrubberSymbolMask;
			addProgressBar();
		}
		/**
		 * Create the Progress Bar, set its initial state, and add to the 
		 * progressBarHolder sprite. 
		 */		
		private function addProgressBar():void{
			progressBar = new Sprite();
			TweenMax.to(progressBar, 0, {alpha:0, scaleX:0});
			var theShapeCreator2:CreateShape = new CreateShape();
			theShapeCreator2.draw(CreateShape.SQUARE_FILLED, progressBar, 0, 0, progressBarWidth, progressBarHeight);
			progressBarHolder.addChild(progressBar);
		}
		/**
		 * Create and add the scrubber symbol, set its initial state, and add 
		 * to the progressBarHolder sprite. 
		 */		
		private function addProgressScrubber ():void {
			var shapeWidth:int = 5;
			var shapeHeight:int = 5;
			scrubberSymbol = new Sprite();
			var theShapeCreator:CreateShape = new CreateShape();
			theShapeCreator.draw(CreateShape.SQUARE_FILLED, scrubberSymbol, 0, 0, shapeHeight, shapeWidth);
			var theDiagonalValue:DiagonalValue = new DiagonalValue();
			theDiagonalValue.setShapeValue(shapeWidth, shapeHeight);
			diagonal = theDiagonalValue.getDiagonalValue();
			TweenMax.to(scrubberSymbol, 0, {alpha:.25, z:0, x:-(diagonal*.5), y:progressBarHeight*.5, rotation:-45});
			progressBarHolder.addChild(scrubberSymbol);
		}
		/**
		 * useing timeline lite loop to update and track the visual progress of 
		 * the MP3.
		 */		
		private function progressHandler ():void {
			var currentTrackLoader:MP3Loader = LoaderMax.getLoader(currentTrack);
			var theProgressNumber:Number = currentTrackLoader.playProgress;
			var scrubberSymbolX:Number = (theProgressNumber*progressBarWidth-(diagonal*.5))-.5;
			myTimeline = new TimelineLite({onComplete:progressHandler});
			myTimeline.append(new TweenMax(scrubberSymbol, .01, {alpha:.25, x:scrubberSymbolX, ease:Linear}));
			myTimeline.append(new TweenMax(progressBar, .01, {alpha:.15, scaleX:theProgressNumber, ease:Linear}));
		}
	}
}