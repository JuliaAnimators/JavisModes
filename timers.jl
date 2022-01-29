module JavisTimer 
import Base

export timer

framerate = 30
currentframe = 1


"""
module contains some functions for manipulating time directly 
not that in general manipulating time is tricky because of 
discrete nature of frames.

"""

struct finterval #frame interval
  """
  an interval of frames
  iterable.

  finterval(b::Int,e::Int)
    makes an interval starting at the b'th frame
    and ending at the e'th frame.

  finterval(e::Int)
    makes an interval starting at `currentframe`
    and ending  `currentframe+e` frame
  """
  beginframe::Int
  endframe::Int
  iterable
end

finterval(b::Int,e::Int) = finterval(b,e,b:e)
finterval(e) = finterval(currentframe,e,currentframe:e)

"""implement iteration on finterval"""
Base.iterate(f1::finterval) = Base.iterate(f1.iterable) 
function Base.iterate(f1::finterval,state)
  return Base.iterate(f1.iterable,state) 
end


function Base.:+(f1::finterval,f2::finterval)
  """adds two intervals, addition is defined as an finterval from
  f1's first frame to f2's last frame
  """
  return finterval(f1.beginframe,f2.endframe) 
end

function Base.:*(x::Real,f1::finterval)
  """scales the interval by x , keeps the beginframe the same"""
  return finterval(f1.beginframe,floor(Int,x*f1.endframe))
end
#another other ideas for * on finterval is to scale around midpoint frame

function Base.length(f::finterval)
  return length(f.iterable)
end

function timer(t::Real)
  """advance currentframe by t seconds of time,
  note that the currentframe is obtained by
  flooring to an `Int`,
  do not expect running `timer(x);timer(y)` to add `x+y` seconds
  to the current timestamp."""
  global currentframe
  beginframe = currentframe
  endframe = currentframe + floor(Int,t*framerate) - 1
  currentframe = endframe + 1
  return finterval(beginframe,endframe)
end

function timer(f::finterval)
  """advance currentframe by the duration same as f, 
  and return apropriate finterval"""
  global currentframe,
  beginframe = currentframe
  Δframe = f.endframe - f.beginframe + 1
  endframe = currentframe + Δframe 
  return finterval(beginframe,endframe)
end

function getframe()
  """ returns currentframe """
  global currentframe
  return currentframe 
end

function setframe(f::Int)
  """ sets current frame to f """
  global currentframe
  currentframe=f
end

function gettime()
  """gets timestamp, time is tricky to work with.
  """
  global currentframe
  return currentframe*framerate
end

function settime(t::Real)
  global currentframe
  currentframe= floor(Int,s*framerate)
end

function settime(f::finterval)
  """set currentframe to end frame of finterval,
  """
  global currentframe
  currentframe = f1.endframe
end

end

