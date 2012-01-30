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
	 * class description: VolumeController
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: christian
	 * created: Jan 27, 2012
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
	import com.greensock.easing.Sine;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import org.casalib.util.StageReference;
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class VolumeController implements ISubject {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var theVolumeControllHolder:Sprite;
		private var theVolumeControllerWidth:int = 44;
		private var theVolumeControllerHeight:int = 22;
		private var levelBar:Sprite;
		private var volumeSliderSymbol:Sprite;
		private var volumeSliderSymbolClickArea:Sprite;
		private var diagonal:Number;
		private var volumeScaleY:Number;
		private var myTimeline:TimelineLite;
		private var observer:ISubject;
		private var currentTrack:String;
		private var currentTrackLoader:MP3Loader;
		private var volumeSlider:Sprite;
		private var theVolumeControlls:Sprite;
		private var volumeParam:Number;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function VolumeController () {}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function initVolumeController ():void {
			addVolumeControllHolder();
		}
		public function getVolumeController ():Sprite {
			return theVolumeControlls;
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
				newTrackVolumeUpdate();
			}
			if(hasOwnProperty(infoObject)) {
				this[infoObject]();
			}
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private function newTrackVolumeUpdate():void{
			volumeParam = Math.abs(volumeScaleY);
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			TweenMax.to(currentTrackLoader, .01, {volume:Math.abs(volumeParam)});
		}
		/**
		 * Create and add progress bar holder sprite which will act as our
		 * returned Object. Next create and add a mask for all included objects.
		 */
		private function addVolumeControllHolder ():void {
			volumeScaleY = 1;
			volumeParam = Math.abs(volumeScaleY)
			theVolumeControllHolder = new Sprite();
			var volumeSymbolMask:Sprite = new Sprite();
			TweenMax.to(volumeSymbolMask, 0, {y:-theVolumeControllerHeight});
			theVolumeControllHolder.addChild(volumeSymbolMask);
			var theShapeCreator:CreateShape = new CreateShape();
			theShapeCreator.draw(CreateShape.SQUARE_FILLED, volumeSymbolMask, 0, 0, theVolumeControllerWidth, theVolumeControllerHeight);
			theVolumeControllHolder.mask = volumeSymbolMask;
			addLevelBar();
		}
		/**
		 * Create the Progress Bar, set its initial state, and add to the
		 * progressBarHolder sprite.
		 */
		private function addLevelBar ():void {
			levelBar = new Sprite();
			var theShapeCreator2:CreateShape = new CreateShape();
			theShapeCreator2.draw(CreateShape.SQUARE_FILLED, levelBar, 0, 0, theVolumeControllerWidth, theVolumeControllerHeight);
			TweenMax.to(levelBar, 0, {alpha:.25, x:theVolumeControllerWidth, y:0, height:volumeParam, rotation:180});
			theVolumeControllHolder.addChild(levelBar);
			addVolumeSlider();
		}
		/**
		 * Create and add the scrubber symbol, set its initial state, and add
		 * to the progressBarHolder sprite.
		 */
		private function addVolumeSlider ():void {
			var shapeWidth:int = 5;
			var shapeHeight:int = 5;
			volumeSliderSymbol = new Sprite();
			var theShapeCreator:CreateShape = new CreateShape();
			theShapeCreator.draw(CreateShape.SQUARE_FILLED, volumeSliderSymbol, 0, 0, shapeHeight, shapeWidth);
			var theDiagonalValue:DiagonalValue = new DiagonalValue();
			theDiagonalValue.setShapeValue(shapeWidth, shapeHeight);
			diagonal = theDiagonalValue.getDiagonalValue();
			TweenMax.to(volumeSliderSymbol, 0, {alpha:.25, tint:0xFFFFFF, z:0, x:(theVolumeControllerWidth * .5) - (diagonal * .5), y:-theVolumeControllerHeight+volumeParam, rotation:-45});
			theVolumeControllHolder.addChild(volumeSliderSymbol);
			volumeControlls();
		}
		private function volumeControlls():void{
			theVolumeControlls = new Sprite();
			theVolumeControlls.addChild(theVolumeControllHolder);
			TweenMax.to(theVolumeControllHolder, 0, {y:theVolumeControllerHeight});
			clickAreaShape();
		}
		/**
		 * Create and add the scrubber symbol click area.
		 */
		private function clickAreaShape ():void {
			var clickAreaShapeWidth:int = 14;
			var clickAreaShapeHeight:int = 14;
			volumeSliderSymbolClickArea = new Sprite();
			var clickAreaShapeCreator:CreateShape = new CreateShape();
			clickAreaShapeCreator.draw(CreateShape.SQUARE_FILLED, volumeSliderSymbolClickArea, 0, 0, clickAreaShapeHeight, clickAreaShapeWidth);
			var theClickAreaDiagonalValue:DiagonalValue = new DiagonalValue();
			theClickAreaDiagonalValue.setShapeValue(clickAreaShapeWidth, clickAreaShapeHeight);
			var clickAreaDiagonal:Number = theClickAreaDiagonalValue.getDiagonalValue();
			TweenMax.to(volumeSliderSymbolClickArea, 0, {alpha:0, tint:0x000000, z:0, x:-(clickAreaDiagonal * .25), y:-(clickAreaDiagonal * .25)});
			volumeSliderSymbol.addChild(volumeSliderSymbolClickArea);
			volumeSlider = new Sprite();
			addDragEvents();
		}
		/**
		 * Add mouse events for the scrubber.
		 */
		private function addDragEvents ():void {
			volumeSliderSymbol.buttonMode = true;
			volumeSliderSymbol.doubleClickEnabled = true;
			volumeSliderSymbol.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			volumeSliderSymbol.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			volumeSliderSymbol.addEventListener(MouseEvent.MOUSE_OUT, placementTargetOut);
			volumeSliderSymbol.addEventListener(MouseEvent.MOUSE_OVER, placementTargetOver);
		}
		private function placementTargetOver (overEvent:MouseEvent):void {
			TweenMax.to(volumeSliderSymbol, .25, {alpha:1, ease:Sine.easeOut});
		}
		private function placementTargetOut (outEvent:MouseEvent):void {
			TweenMax.to(volumeSliderSymbol, .75, {alpha:.5, ease:Sine.easeOut});
		}
		/**
		 * On mouse down;
		 * add stage event listener for on release outside events.
		 * pause the play loop update so we can move the scrubber without interruption.
		 * asign startDrag to scrubber and update the progress bar width to match.
		 */
		private function mouseDownHandler (event:MouseEvent):void {
			TweenMax.to(volumeSliderSymbol, .25, {alpha:1, tint:0x3399FF, ease:Sine.easeOut});
			StageReference.getStage().addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			var dragConstraintX:Number = (theVolumeControllerWidth * .5) - ((diagonal * .5) - .5);
			var dragConstraints:Rectangle = new Rectangle(dragConstraintX, 0, 0, -theVolumeControllerHeight);
			volumeSliderSymbol.startDrag(false, dragConstraints);
			volumeUpdate();
		}
		/**
		 * Animate the progress bar  with a loop to match the current postion
		 * of the scrubber.
		 */
		private function volumeUpdate ():void {
			volumeParam = Math.abs(volumeScaleY);
			volumeScaleY = (volumeSliderSymbol.y / theVolumeControllerHeight);
			myTimeline = new TimelineLite({onComplete:volumeUpdate});
			myTimeline.append(new TweenMax(levelBar, .01, {scaleY:Math.abs(volumeScaleY), ease:Linear}));
			
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			myTimeline.append(new TweenMax(currentTrackLoader, .01, {volume:Math.abs(volumeScaleY)}));
		}
		/**
		 * On mouse up;
		 * remove stage event listener for on release outside events.
		 * stopDrag to the volume slider.
		 * cancel update loop.
		 */
		private function mouseUpHandler (event:MouseEvent):void {
			TweenMax.to(volumeSliderSymbol, .5, {alpha:.5, tint:0xFFFFFF, ease:Sine.easeOut});
			StageReference.getStage().removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			var currentTrackLoader:MP3Loader = LoaderMax.getLoader(currentTrack);
			volumeSliderSymbol.stopDrag();
			myTimeline.stop();
		}
	}
}