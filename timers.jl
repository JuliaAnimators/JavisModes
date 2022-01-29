module JavisTimer 
import Base

export timer

framerate = 30
currentframe = 1

struct finterval #frame interval
  beginframe::Int
  endframe::Int
  iterable
end

finterval(b,e) = finterval(b,e,b:e)
finterval(e) = finterval(currentframe,e,currentframe:e)

function getrange(f::finterval)
  return f.beginframe:f.endframe
end

Base.iterate(f1::finterval) = Base.iterate(f1.iterable) 

function Base.iterate(f1::finterval,state)
  return Base.iterate(f1.iterable,state) 
end

function Base.:+(f1::finterval,f2::finterval)
  return finterval(f1.beginframe,f2.endframe) 
end

function Base.:*(x::Real,f1::finterval)
  return finterval(f1.beginframe,floor(Int,x*f1.endframe))
end
#another other ideas for * on finterval is to scale around midpoint frame

function Base.length(f::finterval)
  return length(f.iterable)
end

function timer(t::Real)
  """advance currentframe by t seconds of time"""
  global currentframe,framerate
  beginframe = currentframe
  endframe = currentframe + floor(Int,t*framerate) - 1
  currentframe = endframe + 1
  return finterval(beginframe,endframe)
end

function timer(f::finterval)
  """advance currentframe by the duration same as f, 
  and return apropriate finterval"""
  global currentframe,framerate
  beginframe = currentframe
  Δframe = f.endframe - f.beginframe + 1
  endframe = currentframe + Δframe 
  return finterval(beginframe,endframe)
end

function getframe()
  global currentframe,framerate
  return currentframe 
end

function setframe(f::Int)
  global currentframe,framerate
  currentframe=f
end

function gettime()
  global currentframe,framerate
  return currentframe*framerate
end

function settime(t::Real)
  global currentframe,framerate
  currentframe= floor(Int,s*framerate)
end

function settime(f::finterval)
  """set currentframe to end frame of finterval,
  """
  currentframe
end

end
