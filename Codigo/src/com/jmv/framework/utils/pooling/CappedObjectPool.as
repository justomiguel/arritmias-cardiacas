package com.jmv.framework.utils.pooling 
{
	/**
	 * ...
	 * @author Miguel
	 */
	public class CappedObjectPool {
		
		private var _minSize : int;
        private var _maxSize : int;
        public var size : int = 0;

        public var create : Function;
        public var clean : Function;
        public var length : int = 0;

        private var list : Array = [];
        private var disposed : Boolean = false;
                
                /*
                 * @param create This is the Function which should return a new Object to populate the Object pool
                 * @param clean This Function will recieve the Object as a param and is used for cleaning the Object ready for reuse
                 * @param minSize The initial size of the pool on Pool construction
                 * @param maxSize The maximum possible size for the Pool
                 */

                public function CappedObjectPool(create : Function, clean : Function = null, minSize : int = 50, maxSize : int = 200) {
                        this.create = create;
                        this.clean = clean;
                        this.minSize = minSize;
                        this.maxSize = maxSize;
                        
                        for(var i : int = 0;i < minSize; i++) add();
                }

                private function add() : void {
                        list[length++] = create();
                        size++;
                }
                
                /*
                 * Sets the minimum size for the Pool
                 */
                public function set minSize(num : int) : void {
                        _minSize = num;
                        if(_minSize > _maxSize) _maxSize = _minSize;
                        if(_maxSize < list.length) list.splice(_maxSize);
                        size = list.length;
                }
                
                /*
                 * Gets the minimum size for the Pool
                 */
                public function get minSize() : int {
                        return _minSize;
                }
                
                /*
                 * Sets the maximum size for the Pool
                 */
                public function set maxSize(num : int) : void {
                        _maxSize = num;
                        if(_maxSize < list.length) list.splice(_maxSize);
                        size = list.length;
                        if(_maxSize < _minSize) _minSize = _maxSize;
                }
                
                /*
                 * Returns the maximum size for the Pool
                 */
                public function get maxSize() : int {
                        return _maxSize;
                }
                
                /*
                 * Checks out an Object from the pool
                 */
                public function checkOut() : * {
                        if(length == 0) {
                                if(size < maxSize) {
                                        size++;
                                        return create();
                                } else {
                                        return null;
                                }
                        }
                        
                        return list[--length];
                }
                
                /*
                 * Checks the Object back into the Pool
                 * @param item The Object you wish to check back into the Object Pool
                 */
                public function checkIn(item : *) : void {
                        if(clean != null) clean(item);
                        list[length++] = item;
                }
                
                /*
                 * Disposes the Pool ready for GC
                 */
                public function dispose() : void {
                        if(disposed) return;
                        
                        disposed = true;
                        
                        create = null;
                        clean = null;
                        list = null;
                }
		
	}

}