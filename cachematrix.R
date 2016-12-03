## Functions to cache the inverse of a matrix

## Essentially creates an object to allow us to access a matrix and 
## (potentially) its inverse
## Input: x, an invertible matrix; set to NA as default
## Output: a list of functions
##  set: change the matrix to a new invertible matrix passed as argument,
##      resets the inverse to NULL
##  get: return the current matrix
##  setinv: set the inverse to the matrix passed as argument
##  getinv: return the current inverse

makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  set <- function(y){
    x <<- y
    inv <<- NULL
  }
  get <- function() x
  setinv <- function(inverse) inv <<- inverse
  getinv <- function() inv
  list(set = set, get = get,
       setinv = setinv,
       getinv = getinv)

}


## Computes and/or retrieves from cache the inverse of a matrix
## Input: x, a value returned by makeCacheMatrix
## Output: the inverse of the matrix stored in x
cacheSolve <- function(x) {
  inv <- x$getinv()
  if(!is.null(inv)){
    message("getting cached data")
    return(inv)
  }
  mat <- x$get()
  inv <- solve(mat)
  x$setinv(inv)
  inv
}
