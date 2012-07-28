package com.jmv.sbejeweled._game_._board_
{
	import com.jmv.framework.core.SSprite;
	import com.jmv.framework.events.SEvent;
	import com.jmv.framework.math.SMath;
	import com.jmv.framework.tween.STween;
	import com.jmv.framework.utils.ArrayUtil;
	import com.jmv.framework.utils.assert;
	import com.jmv.framework.utils.foreach;
	import com.jmv.framework.utils.ObjectUtil;
	import com.jmv.sbejeweled._game_._board_.chips.*;
	import com.jmv.sbejeweled._game_._board_.powerups.*;
	import com.jmv.sbejeweled._game_.effects.AbstractEffect;
	import com.jmv.sbejeweled._game_.players.AbstractPlayer;
	import com.jmv.sbejeweled.settings;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.setTimeout;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	
	
	public class Board extends SSprite
	{
		public static const COLS:int = 8;
		public static const ROWS:int = 7;
		
		public static const BOARD_INITIAL_X:int = -45;
		public static const BOARD_INITIAL_Y:int = 10;
		
		public static const PLAY_SFX:String = 'event_play_sfx';
		public static const SHOW_POPUP:String = 'event_show_popup';
		public static const ADD_TOKENS:String = 'event_add_tokens';
		public static const REMOVE_TOKENS:String = 'event_remove_tokens';
		public static const CREATE_CHIP:String = 'event_create_chip';
		public static const STANDBY_TRUE:String = 'event_stand_by_true'
		public static const MATCH_DONE:String = 'event_match_done'; 
		public static const POWERUP_MATCH:String = 'event_powerup_match'; //Michael
		
		
		//public var tasks:TaskRunner;
		public var fallingChips:Object;
		public var tiles:Array;
		public var speedMult:Number = 1;
		
		private var selectedTile:Tile;
		private var standBy:Boolean;
		private var intro:Intro;
		
		private var powerUpCounter:int = 0;
		

		private var colorodds:Object;
		
		private var chainMatches:int;
		private var soundMatchCounter:int;
		private var chainMatchesCounter:int;
		private var shuffler:Shuffler;
		
		public var player:AbstractPlayer;
		private var powerups:Object;
		private var contDestroyRowCol:int;
		private var contDestroyRow:int;
		private var actualPowerUP:int;
		
		
		private var contCheckes:int;
		
		
		public function Board(task:*, _colorodds:Object, _powerups:Object) {

				super();		
			//this.tasks = task;
			
			actualPowerUP = 1;
			
			contDestroyRow = 0;
			contDestroyRowCol = 0;
			
			this.chainMatches = 0;
			this.shuffler = new Shuffler(this);
			
			this.colorodds = _colorodds;
			this.powerups = _powerups;
			
			this.mouseChildren = true;
			this.mouseEnabled = true;
			
			contCheckes = 0;
			this.initLayers();			
			
			this.initTiles();
			this.initChips();
			
		
			this.intro = new Intro(this);
			
			this.intro.addEventListener(Event.COMPLETE, this.onIntroComplete, false, 0, true);
			
		}
		
		private function onExternalDoFillGaps(ev:SEvent):void
		{
			this.chainMatches = 0;
			if (this.standBy) this.fillGaps();
		}
		
		public function isStandBy():Boolean
		{
			return this.standBy;
		}
		
		private function initLayers():void
		{			
			this.addLayer(BoardLayer.TILES);
			var myTiles:Sprite = (this.getChildByPath(BoardLayer.TILES) as Sprite);
			myTiles.x = BOARD_INITIAL_X;
			myTiles.y = BOARD_INITIAL_Y;
			this.addMouseDisabledLayer(BoardLayer.EFFECTS_UNDER);
			var myEffect:Sprite = (this.getChildByPath(BoardLayer.EFFECTS_UNDER) as Sprite);
			myEffect.x = BOARD_INITIAL_X;
			myEffect.y = BOARD_INITIAL_Y;
			this.addMouseDisabledLayer(BoardLayer.CHIPS);
			var myChips:Sprite = (this.getChildByPath(BoardLayer.CHIPS) as Sprite);
			myChips.x = BOARD_INITIAL_X;
			myChips.y = BOARD_INITIAL_Y;
			this.addMouseDisabledLayer(BoardLayer.EFFECTS);
			var myEffectS:Sprite = (this.getChildByPath(BoardLayer.EFFECTS) as Sprite);
			myEffectS.x = BOARD_INITIAL_X ;
			myEffectS.y = BOARD_INITIAL_Y;
		}
		
		public function tileAt(row:int, col:int):Tile
		{
			if (row<0 || row>=ROWS || col<0 || col>=COLS) return null;
			return (this.tiles[row*COLS + col] as Tile); 
		}
		
		public function clickOnTile(tile:Tile):void
		{
			if (!this.standBy) return;
			
			assert(tile == this.tileAt( tile.row, tile.col ) );
			
			if ( !tile.currentChip ||
			     !tile.currentChip.isSwappealble() || 
			      tile == this.selectedTile)
			{
				if (this.selectedTile){
					this.selectedTile.currentChip.setState('stable');
					this.selectedTile = null;
				}
				return;	
			}
			
			tile.currentChip.setState('selected');
			this.dispatch(PLAY_SFX, 'tokens_select');
			
			if (!this.selectedTile)
			{
				this.selectedTile = tile;
			}
			else 
			{
				if ( this.areTilesAdjacent( tile ) )
				{
					this.standBy = false;
					//this.tasks.setTimeout( this.swap, this.speedMult * 100, this.selectedTile, tile, true);
					setTimeout(this.swap, this.speedMult * 100, this.selectedTile, tile, true)
				}
				else
				{
					this.selectedTile.currentChip.setState('stable');
					this.selectedTile = tile;
				}
			}
		}
		
		public function getIntro():Intro
		{
			return this.intro;
		}
				
		public function addEffect(effect:AbstractEffect, _x:Number, _y:Number):void
		{
			effect.x = _x;
			effect.y = _y;
			this.addChildAtPath(BoardLayer.EFFECTS, effect );
		}
		
		private function addMouseDisabledLayer(path:String):SSprite
		{
			var sprite:SSprite = this.addLayer(path);
			sprite.mouseChildren = false;
			sprite.mouseEnabled = false;
			return sprite;
		}
		
		private function onIntroComplete(e:Event = null):void
		{
			this.standBy = true;
			this.intro = null;			
		}
		
		private function initTiles():void
		{
			this.tiles = [];
			
			for(var row:int = 0; row < ROWS; row++)
			{
				for(var col:int = 0; col < COLS; col++)
				{
					var tile:Tile = new Tile(this, row, col);
					this.addChildAtPath('tiles', tile)
					
					this.tiles.push( tile );
				}
			}
		}
		
		private function initChips():void
		{
			for each (var tile:Tile in this.tiles)
			{
				var chip:AbstractChip;
				do
				{
					chip = ChipFactory.createWeightedRandom(this.colorodds);
					tile.setChip( chip );					
				} 
				while ( this.getSameColorLine(tile,  0, -1 ).length > 2 ||
				        this.getSameColorLine(tile, -1,  0 ).length > 2   );
						  
				this.addChildAtPath(BoardLayer.CHIPS, chip);
				chip.alpha = 0;
			}
		}
		
		private function getSameColorLine(tile:Tile, deltax:int, deltay:int):Array
		{
			if ( !(tile.currentChip is StandardChip)) return [];
			
			var nextTile:Tile = this.tileAt(tile.row + deltay, tile.col + deltax) 
			if (nextTile && nextTile.currentChip && nextTile.currentChip.getType() == tile.currentChip.getType()){
				return this.getSameColorLine(nextTile, deltax, deltay).concat( tile ); 
			} else {
				return [tile];
			}
		}
		
		private function findSimpleMatches(verticalLines:Array, horizontalLines:Array):Array
		{
			var groups:Array = [];
			
			var lineLength:int = 3;
			
			var tile:Tile, color:String;

			for each (tile in this.tiles)
			{
				if (verticalLines.indexOf( tile ) >= 0) continue;
				var line:Array = this.getSameColorLine(tile, 0, 1);
				if (line.length >= lineLength) {
					
					foreach( line, verticalLines.push);
					groups.push( line );
				}
			}
			//check for horizontal matches
			for each (tile in this.tiles)
			{
				if (horizontalLines.indexOf( tile ) >= 0) continue;
				var line2:Array = this.getSameColorLine(tile, 1, 0);
				if (line2.length >= lineLength){
					foreach( line2, horizontalLines.push);
					if (this.intersect(line2, verticalLines)){
						this.mergeNewGroup( groups, line2 );
					} else {
						groups.push( line2 );
					}
				}
			}
			
			return groups;
			
		}
		
		private function findPowerUpDestroyed():Array
		{
			try {
				var powerupDestroyed:Array = [];
				var powerUpTiles:Array = this.tiles.filter(this.hasPowerUp);
				while(powerUpTiles.length > 0){
					for each (var tile:Tile in powerUpTiles)
					{
						foreach( PowerUp(tile.currentChip).doStuff( tile, this ), powerupDestroyed.push );
					}
					powerUpTiles = powerupDestroyed.filter(this.hasUnactivatedPowerUp);
				}
				return powerupDestroyed;
			} catch (err:Error)
			{
				
			}
			powerupDestroyed = [];
			return powerupDestroyed;
		}
		
		private function addPowerUps(groups:Array):void
		{
		
			
			var chip:AbstractChip;
			for each (var group:Array in groups)
			{
				this.chainMatches++;
				this.chainMatchesCounter++;
				this.player.score.matches++;
				chip = null;
				if (group.length == 4)
					chip = new DestroyRow();
				else if (group.length > 4)
					chip = new DestroyColAndRow();
				
				if (chip)
				{
					group.sortOn( ['col', 'row'], Array.NUMERIC | Array.DESCENDING );
					this.addChildAtPath(BoardLayer.CHIPS, chip);
					Tile(group[0]).setChip( chip );
				}
			}
		}
		
		private function checkMatches(firstTime:Boolean):Boolean
		{
			
			if (firstTime){
				this.chainMatches = 0;
				this.contCheckes = 0;
				this.chainMatchesCounter = 0;
				this.soundMatchCounter = 0;
			} 
			this.fallingChips = {};
			
			var powerupDestroyed:Array = this.findPowerUpDestroyed();
			var verticalLines:Array = [], horizontalLines:Array = [];
			var groups:Array = this.findSimpleMatches(verticalLines, horizontalLines);
			
			if (groups.length > 0) {

				this.soundMatchCounter++;
				if (this.soundMatchCounter > 6) this.soundMatchCounter = 6;
			
				this.dispatch(PLAY_SFX, 'match' + this.soundMatchCounter.toString());
			
				
			}
			if (powerupDestroyed.length > 0) {
				for ( var i:String in powerupDestroyed ) {
					switch (powerupDestroyed[ i ].currentChip.getType()){
						case "destroy_row_col":
							contDestroyRowCol++;
						break;
						case "destroy_row":
							contDestroyRow++;
						break;
					}
				}
				this.dispatch(POWERUP_MATCH, powerupDestroyed);
				
			}
			
			var tile:Tile;
			
			var matchingChips:Array = ArrayUtil.removeDuplicates( verticalLines.concat( 
			
			                                                      horizontalLines ).concat(
			                                                      powerupDestroyed ) );
			
			
			if (matchingChips.length > 0) {
				this.dispatch(MATCH_DONE, matchingChips); 
			}
			
			
			
			this.dispatch(REMOVE_TOKENS, { ammount:matchingChips.filter(this.hasColorChip).length } );
			
				
			
			for each (tile in matchingChips)
			{
				if (ArrayUtil.contains( powerupDestroyed, tile)){
					tile.currentChip.remove(true);
				} else{
					tile.currentChip.remove(false);
				}
				tile.setChip();
			}
			
			this.addPowerUps(groups);
			
			
			if (this.chainMatches >= 1) {
				var rand:int = SMath.randint(0, 1);
				if (rand) {
					this.chainMatches = 0;
					this.dispatch(Board.SHOW_POPUP, settings.getIngameText('feelings'));
				} else {
					this.chainMatches = 0;
					this.dispatch(Board.SHOW_POPUP, settings.getIngameText('marketing'));
				}
			}
			
			if ( matchingChips.length > 0){
				this.fillGaps();
				return true;
			}
			
			STween.to(this, 0.5, { onComplete:function():void { standBy = true; }} );
			return false;
		}
		
		
		
		private function fillGaps():void
		{
			var hasHoles:Boolean = false;
			
			var powerUpCol:int = -1;
			if (this.powerUpCounter > 3)
			{
				this.powerUpCounter = 0;
				powerUpCol = SMath.randint( 0, COLS - 1 );
			}
			var tile:Tile;
			//var p:Array = new Array();
			
			for (var col:int = 0; col < COLS; col++)
			{
				var missingSpaces:int = 0;
				for (var row:int = ROWS-1; row >= 0; row--)
				{
					tile = this.tileAt(row, col);
					if (tile.currentChip)
					{
						if (missingSpaces > 0)
							//p.push(tile.currentChip.fallTo( tile, this.tileAt( row + missingSpaces, col), this.speedMult ));
							tile.currentChip.fallTo( tile, this.tileAt( row + missingSpaces, col), this.speedMult )
					} else
					{
						missingSpaces++;
						hasHoles = true;
					}
				}
				
				
					hasHoles = true;
					this.standBy = false;
					var next:Function = function():void {
						//trace("nexte " + next);
						STween.to(this, 0.01, { onStart:dispatch, onStartParams:[PLAY_SFX, 'tokens_fall'], onComplete:checkMatches, onCompleteParams:[false] } )
						
					}
					this.generateNewChips( col, missingSpaces, (col == powerUpCol) , next);
			}
			
			//if (hasHoles){
				//
				//
				//
			//
				//
			//
					//this.tasks.add( new Sequence( p, new Func(this.dispatch, PLAY_SFX, 'tokens_fall'), new Func( this.checkMatches, false ) ) );
					//
			//}
		}
		
		public function unBlockGame():void {
			this.standBy = true;
		}
		private function intersect(group1:Array, group2:Array):Boolean
		{
			for each ( var obj:Object in group1 )
			{
				if (ArrayUtil.contains(group2, obj)) return true;
			}
			return false;
		}
		
		private function mergeNewGroup(groups:Array, newGroup:Array):void
		{
			for each (var group:Array in groups.concat() )
			{
				if (this.intersect( newGroup, group ))
				{
					foreach( ArrayUtil.removeElement( groups, group ) as Array, newGroup.push);
				}
			}
			groups.push( ArrayUtil.removeDuplicates( newGroup ) );
		}
		
		private function getMinColor():String
		{
			var amm:Object = {};
			for each ( var color:String in StandardChip.COLORS)
			{
				amm[color] = 1;
			}
			for each (var tile:Tile in this.tiles)
			{
				if (!tile.currentChip) continue;
				if (amm[tile.currentChip.getType()]) amm[tile.currentChip.getType()]++;
			}
			var min:int = COLS*ROWS, minColor:String = StandardChip.WATER;
			for each ( color in StandardChip.COLORS)
			{
				if (amm[color] > 1 && amm[color] < min)
				{
					minColor = color;
					min = amm[color];
				}
			}
			return minColor;
		}
		
		private function generateChipCondition(chip:AbstractChip, tile:Tile):Boolean
		{
			if (tile){
				if (chip){
					var nextTile:Tile = this.tileAt( tile.row - 1, tile.col );
					if (nextTile) {
						if (this.fallingChips[nextTile.toString()]) {
							var chipVar:AbstractChip = AbstractChip(this.fallingChips[nextTile.toString()]);
							if (chipVar) {
								if (chipVar.getType() == chip.getType()) {
									return false;
								}
							}
						}
					}
					
					
					var nextTile2:Tile = this.tileAt( tile.row, tile.col - 1 );

					if (nextTile2) {
						
						if (this.fallingChips[nextTile2.toString()]) {
							var chipVar2:AbstractChip = AbstractChip(this.fallingChips[nextTile2.toString()]);
							if (chipVar2) {
								if (chipVar2.getType() == chip.getType()) {
									return false;
								}
							}
						}
					}
				}
			}
				return true;
		}
		
		private function isEmpty(obj:Object):Boolean
		{
			for each (var num:Number in obj)
			{
				if (num!=0) return false;
			}
			return true;
		}
		
		private function generateNewChips( col:int, ammount:int, addPowerUp:Boolean = false , nextFunction:Function = null ):Array
		{
			
			var banPowerUP:Boolean = false;
					
			var powerUpRow:int = -1;
			if (((powerups.rowpowerups != 0) || (powerups.rowcolumpowerups != 0)) && (contDestroyRow >= powerups.rowpowerups ) && (contDestroyRowCol  >= powerups.rowcolumpowerups)) {
					contDestroyRow = 0;
					contDestroyRowCol = 0;	
					powerUpRow = Math.floor(Math.random() * (ammount-1) ); 
					banPowerUP = true;
			}
			var odds:Object, tile:Tile, chip:AbstractChip;
			//var p:Array = [];
			var deltay:Number = this.tileAt(0,0).height; 
			for ( var i:int = 0; i < ammount; i++) {
				//trace("i " + i);
				odds = null;
				tile = this.tileAt(i, col);
				
				if ((powerUpRow == i)&&(banPowerUP)){
						banPowerUP = false;
						trace( "powerups.type : " + powerups.type );
						chip = ChipFactory.create(powerups.type, this.getMinColor() );		 
					
			    } else {
					chip = ChipFactory.createWeightedRandom(this.colorodds);
					while ( !this.generateChipCondition(chip,tile) ){
						if (!odds) odds = ObjectUtil.copy(this.colorodds);
						delete odds[chip.getType()];
						
						chip = ChipFactory.createWeightedRandom(odds);
					}
				}
				var cont:int = 0;
				while (!chip) {
					cont++;
					chip = ChipFactory.createRandomStandard();
				}
				chip.y = tile.getChipY() - deltay;
				chip.x = tile.getChipX();
				DisplayObjectContainer(this.getChildByName(BoardLayer.CHIPS)).addChildAt(chip, 0);
				this.fallingChips[tile.toString()] = chip;
				
				if (i+1 == ammount) {
					//p.push( chip.fallTo( null, tile, this.speedMult, true , nextFunction) );
					chip.fallTo( null, tile, this.speedMult, true , {fun:nextFunction})
				} else {
					//p.push( chip.fallTo( null, tile, this.speedMult, true ) );
					chip.fallTo( null, tile, this.speedMult, true ) 
				}
				
			}
			
			
			return [];
		}
		
		private function existPowerUps(obj:Object):Boolean
		{
			//trace( "existPowerUps : " + existPowerUps );
			
			if ((obj.destroy_color == obj.swap_color) && (obj.swap_color == obj.destroy_random) && (obj.swap_color == 0)) {
				
				return false;
			} else {
				return true;
			}
		}
		
		private function activatePowerUp(chip:AbstractChip, othersType:String):void
		{
			//trace("ES CHIP" + chip)
			//trace("TIPOOOOOOOOOOOOOo" + chip.type);
			//trace( "othersType : " + othersType );
			
			if (!(chip is PowerUp)) return;
			var power:PowerUp = PowerUp(chip);
			power.activate(othersType);
			
			this.powerUpCounter += power.powerUpCount;
			this.player.score.sum(power.score);
		}
		
		private function swap(tile1:Tile, tile2:Tile, validate:Boolean):void
		{
			try {
				this.selectedTile = null;
			
				if (tile1.currentChip.parent.getChildIndex( tile1.currentChip ) < tile2.currentChip.parent.getChildIndex( tile2.currentChip ))
					tile1.currentChip.parent.swapChildren( tile1.currentChip, tile2.currentChip );
				
				
				this.activatePowerUp(tile1.currentChip, tile2.currentChip.getType());
				this.activatePowerUp(tile2.currentChip, tile1.currentChip.getType());

				this.standBy = false;
				var func:Function = validate? this.validateSwap : this.onEndSwap;
								
				STween.to(tile1.currentChip, 600 * this.speedMult / 1000, { x:tile2.currentChip.x, y:tile2.currentChip.y } )
				STween.to(tile2.currentChip, 600 * this.speedMult / 1000, { x:tile1.currentChip.x, y:tile1.currentChip.y , onComplete:func,onCompleteParams:[ tile1, tile2, validate]} )
			} catch (err:Error)
			{
				
			}
			
			
		}
		
		private function validateSwap(tile1:Tile, tile2:Tile, validate:Boolean):void
		{
			this.onEndSwap(tile1, tile2, true);
			if (this.checkMatches(true)){
				if (tile1.currentChip) tile1.currentChip.setState('stable');
				if (tile2.currentChip) tile2.currentChip.setState('stable');
			} else {
				this.dispatch(PLAY_SFX, 'match_wrong');
				this.swap(tile1, tile2, false);
			}
		}
		
		private function onEndSwap(tile1:Tile, tile2:Tile, validate:Boolean):void
		{
			if (!validate){
				tile1.currentChip.setState('stable');
				tile2.currentChip.setState('stable');
			}
			var chip:AbstractChip = tile1.currentChip;
			tile1.setChip(tile2.currentChip);
			tile2.setChip(chip);
			this.standBy = true;
		}
		
		private function onExternalDoShuffle(ev:SEvent):void
		{
			if (!this.standBy) return;
			this.standBy = false;
			
			//var p:Parallel;
			if (ev.data as int == -2)
			{
				this.shuffler.noMoreMoves(1500, setStandByTrue);
				this.dispatch(SHOW_POPUP, 'nomoves');
			}
			else
				this.shuffler.shuffle(ev.data as int, 900*this.speedMult, setStandByTrue);			                                     
			
			//this.tasks.add( new Sequence(p, new Func(this.setStandByTrue)) );
		}
		
		private function areTilesAdjacent(tile:Tile):Boolean
		{
			if (!this.selectedTile || !tile) return false;
			return (Math.abs((tile.col - this.selectedTile.col)) + 
					Math.abs((tile.row - this.selectedTile.row)) == 1)
		}
		
	
		public function hasPowerUp(tile:*, index:int = 0, array:Array = null):Boolean
		{
			return (tile.currentChip && tile.currentChip is PowerUp);
		}
		
		public function hasColorChip(tile:*, index:int = 0, array:Array = null):Boolean
		{
			return (tile.currentChip && tile.currentChip is StandardChip);
		}

		private function hasUnactivatedPowerUp(tile:*, index:int = 0, array:Array = null):Boolean
		{
			if (this.hasPowerUp(tile) && !PowerUp(Tile(tile).currentChip).activated)
			{
				PowerUp(Tile(tile).currentChip).activate();
				this.powerUpCounter += PowerUp(tile.currentChip).powerUpCount;
				return true;
			}
			return false;
		}
		
		private function setStandByTrue():void
		{
			this.standBy = true;
		}
		
		public function dispatch(type:String, data:Object):void
		{
			//trace("despache evento " + type + " con data " + data);
			
			this.dispatchEvent( new SEvent(type, data) );
		}
		
		public override function dispose():void
		{
			this.shuffler.dispose();
			
			for each (var tile:Tile in this.tiles)
			{
				tile.dispose();
			}
			
			if (this.fallingChips) 
			{
				for each (var chip:AbstractChip in this.fallingChips)
				{
					chip.dispose();
				}
			}
			
			this.tiles = null;
			this.fallingChips = null;
			
			super.dispose();
		}
		
		public function get gamePowerups():Object { return powerups; }
		
		public function set gamePowerups(value:Object):void 
		{
			powerups = value;
		}
		
		public function get gameColorodds():Object { return colorodds; }
		
		public function set gameColorodds(value:Object):void 
		{
			colorodds = value;
		}
		
	}	
}


