////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright 2012 Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package com.cw.view.interfaceElements {
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * class description: ProgressIndicator
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: christian
	 * created: Jan 23, 2012
	 * TODO: Fix click area center math.
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import com.cw.control.observer.ISubject;
	import com.cw.utilities.math.DiagonalValue;
	import com.cw.utilities.math.RatioConversion;
	import com.cw.view.shapeCreators.CreateShape;
	import com.cw.view.tweenStates.ButtonOnOffStates;
	import com.cw.view.tweenStates.ButtonStates;
	import com.greensock.TimelineLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Sine;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.casalib.util.StageReference;
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class ProgressIndicator implements ISubject {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var progressBarHolder:Sprite;
		private var progressBar:Sprite;
		private var progressBarWidth:int = 298;
		private var progressBarHeight:int = 20;
		private var scrubberSymbol:Sprite;
		private var scrubberSymbolClickArea:Sprite;
		private var observer:ISubject;
		private var currentTrack:String;
		private var currentTrackLoader:MP3Loader;
		private var currentPosition:String;
		private var myTimeline:TimelineLite;
		private var theStateOfPlay:Boolean;
		private var diagonal:Number;
		private var progressScaleX:Number;
		private var scrubberSymbolX:Number;
		private var theButtonStates:ButtonStates = new ButtonStates();
		private var theButtonOnOffStates:ButtonOnOffStates = new ButtonOnOffStates();
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function ProgressIndicator () {}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function initProgressBar ():void {
			addProgressBarHolder();
			addProgressScrubber();
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
		public function theForwardStateOn():void{
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
			TweenMax.to(scrubberSymbol, .2, {alpha:.5, x:(0 - (diagonal * .5) - .5), ease:Linear});
			TweenMax.to(progressBar, .2, {alpha:.15, scaleX:0, ease:Linear});
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
		private function addProgressBar ():void {
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
			TweenMax.to(scrubberSymbol, 0, {alpha:.25, tint:0xFFFFFF,  z:0, x:-(diagonal * .5), y:progressBarHeight * .5, rotation:-45});
			progressBarHolder.addChild(scrubberSymbol);
			clickAreaShape();
		}
		/**
		 * Create and add the scrubber symbol click area.
		 */
		private function clickAreaShape():void{
			var clickAreaShapeWidth:int = 14;
			var clickAreaShapeHeight:int = 14;
			scrubberSymbolClickArea = new Sprite();
			var clickAreaShapeCreator:CreateShape = new CreateShape();
			clickAreaShapeCreator.draw(CreateShape.SQUARE_FILLED, scrubberSymbolClickArea, 0, 0, clickAreaShapeHeight, clickAreaShapeWidth);
			var theClickAreaDiagonalValue:DiagonalValue = new DiagonalValue();
			theClickAreaDiagonalValue.setShapeValue(clickAreaShapeWidth, clickAreaShapeHeight);
			var clickAreaDiagonal:Number = theClickAreaDiagonalValue.getDiagonalValue();
			TweenMax.to(scrubberSymbolClickArea, 0, {alpha:0, tint:0x000000, z:0, x:-(clickAreaDiagonal * .25), y:-(clickAreaDiagonal * .25)});
			scrubberSymbol.addChild(scrubberSymbolClickArea);
			addDragEvents();
		}
		/**
		 * Useing timeline lite loop to update and track the visual progress of
		 * the MP3.
		 */
		private function progressHandler ():void {
			var currentTrackLoader:MP3Loader = LoaderMax.getLoader(currentTrack);
			var theProgressNumber:Number = currentTrackLoader.playProgress;
			scrubberSymbolX = (theProgressNumber * progressBarWidth - (diagonal * .5)) - .5;
			myTimeline = new TimelineLite({onComplete:progressHandler});
			myTimeline.append(new TweenMax(scrubberSymbol, .01, {alpha:.5, x:scrubberSymbolX, ease:Linear}));
			myTimeline.append(new TweenMax(progressBar, .01, {alpha:.35, scaleX:theProgressNumber, ease:Linear}));
		}
		/**
		 * Add mouse events for the scrubber.
		 */
		private function addDragEvents ():void {
			scrubberSymbol.buttonMode = true;
			scrubberSymbol.doubleClickEnabled = true;
			scrubberSymbol.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			scrubberSymbol.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			scrubberSymbol.addEventListener(MouseEvent.MOUSE_OUT, placementTargetOut);
			scrubberSymbol.addEventListener(MouseEvent.MOUSE_OVER, placementTargetOver);
		}
		private function placementTargetOver (overEvent:MouseEvent):void {
			TweenMax.to(scrubberSymbol, .25, {alpha:1, ease:Sine.easeOut});
		}
		private function placementTargetOut (outEvent:MouseEvent):void {
			TweenMax.to(scrubberSymbol, .75, {alpha:.5, ease:Sine.easeOut});
		}
		/**
		 * On mouse down;
		 * add stage event listener for on release outside events.
		 * pause the play loop update so we can move the scrubber without interruption.
		 * asign startDrag to scrubber and update the progress bar width to match.
		 */
		private function mouseDownHandler (event:MouseEvent):void {
			TweenMax.to(scrubberSymbol, .25, {alpha:1, tint:0x3399FF, ease:Sine.easeOut});
			StageReference.getStage().addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			thePauseStateOn();
			notifyObservers ('scrubber');
			var dragConstraintX:Number = -((diagonal * .5) - .5);
			var dragConstraints:Rectangle = new Rectangle(dragConstraintX, progressBarHeight * .5, progressBarWidth-.5, 0);
			scrubberSymbol.startDrag(false, dragConstraints);
			var scrubberSymbolX:Number = scrubberSymbolX;
			progressUpdate();
		}
		/**
		 * Animate the progress bar  with a loop to match the current postion 
		 * of the scrubber.
		 */		
		private function progressUpdate ():void {
			progressScaleX = (scrubberSymbol.x + ((diagonal * .5) - .5)) / progressBarWidth;
			myTimeline = new TimelineLite({onComplete:progressUpdate});
			myTimeline.append(new TweenMax(progressBar, .3, {scaleX:progressScaleX, ease:Linear}));
		}
		/**
		 * On mouse up;
		 * remove stage event listener for on release outside events.
		 * play loop update to see track progress.
		 * perform a ratio conversion to extrapolate the postion in seconds from 
		 * the percentage postion.
		 * stopDrag to scrubber.
		 * play
		 */
		private function mouseUpHandler (event:MouseEvent):void {
			TweenMax.to(scrubberSymbol, .5, {alpha:.5, tint:0xFFFFFF, ease:Sine.easeOut});
			StageReference.getStage().removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			var currentTrackLoader:MP3Loader = LoaderMax.getLoader(currentTrack);
			var theDurationNumber:Number = currentTrackLoader.duration;
			var theRatioConversion:RatioConversion = new RatioConversion();
			var setScrubberParam:Number = theRatioConversion.ratioConversionInterface(progressScaleX, 0, 1, 0, theDurationNumber);
			currentTrackLoader.gotoSoundTime(setScrubberParam, true);
			scrubberSymbol.stopDrag();
			notifyObservers ('play');
		}
	}
}
