# A16351004

# Import necessary libraries for computation
import math
import numpy

# Test 1: q=[3.4], p1=[1,1], p2=[2,2]
# Test 2: q=[1,2], p1=[0,2], p2=[2,2]
# Test 3: q=[5,2], p1=[2,0], p2=[2,2]

# User input of values
x1 = float(input('Enter x1 value  '))
y1 = float(input('Enter y1 value  '))
x2 = float(input('Enter x2 value  '))
y2 = float(input('Enter y2 value  '))
x3 = float(input('Enter Point x value  '))
y3 = float(input('Enter Point y value  '))

# Definition of points
p1=[x1,y1]
p2=[x2,y2]
q=[x3,y3]

# Getting magnitude of vector
def mag(v):
    sum = 0
    for i in range(len(v)):
        sq = numpy.square(v[i])
        sum = sum + sq
    return math.sqrt(sum)

# Defininig constants of line through points
def computeLineThroughTwoPoints(p,q):
    ap = q[1] - p[1]
    bp = -(q[0] - p[0])
    c = p[1]*(q[0] - p[0])

    a = ap/math.sqrt(numpy.square(ap) + numpy.square(bp))
    b = bp/math.sqrt(numpy.square(ap) + numpy.square(bp))

    return [a, b, c]

# Computing distance between point to line
def computeDistancePointToLine(pr,p,q):
    u = [(pr[0] - p[0]), (pr[1] - p[1])]
    v = [(q[0] - p[0]), (q[1] - p[1])]
    #project = float(numpy.dot(u,v)/numpy.dot(v,v))*v
    project = [0,0]
    for i in range(len(v)):
        project[i] = float(numpy.dot(u,v)/numpy.dot(v,v))*v[i]

    dis = math.sqrt(numpy.square(mag(u)) - numpy.square(mag(project)))
    return dis

# Computing distance between points
def computeDistancePointToPoint(p,q):
    r = mag([(q[0] - p[0]), (q[1] - p[1])])
    return r

# Computing distance to segment
def computeDistancePointToSegment(pr,p,q):
    d_refP = computeDistancePointToPoint(pr,p)
    d_refQ = computeDistancePointToPoint(pr,q)

    # Projection relative to p1
    u1 = [(pr[0] - p[0]), (pr[1] - p[1])]
    v1 = [(q[0] - p[0]), (q[1] - p[1])]
    pro_s1 = float(numpy.dot(u1,v1)/numpy.dot(v1,v1))
    project1 = [0,0]
    for i in range(len(v1)):
        project1[i] = float(numpy.dot(u1,v1)/numpy.dot(v1,v1))*v1[i]

    # Projection relative to p2
    u2 = [(pr[0] - q[0]), (pr[1] - q[1])]
    v2 = [(p[0] - q[0]), (p[1] - q[1])]
    pro_s2 = float(numpy.dot(u2,v2)/numpy.dot(v2,v2))
    project2 = [0,0]
    for i in range(len(v2)):
        project2[i] = float(numpy.dot(u2,v2)/numpy.dot(v2,v2))*v2[i]

    # Determining w value
    if d_refP == d_refQ:
        # Strictly inside the segment
        w = 0
        d = computeDistancePointToLine(pr,p,q)
    elif d_refP < d_refQ:
        # Distance to p1 smaller than distance to p2
        w = 1
        if pro_s1 < 0 or mag(v1) < mag(project1):
            d = computeDistancePointToPoint(pr,p)
        else:
            d = computeDistancePointToLine(pr,p,q)
    elif d_refP > d_refQ:
        # Distance to p1 smaller than distance to p2
        w = 2
        if pro_s2 < 0 or mag(v2) < mag(project2):
            d = computeDistancePointToPoint(pr,q)
        else:
            d = computeDistancePointToLine(pr,p,q)

    return [d,w]


print('Line constants: ')
print(computeLineThroughTwoPoints(p1,p2))
print('Distance from q to line specified: ')
print(computeDistancePointToLine(q,p1,p2))
print('Distance from point q to a segment: ')
print(computeDistancePointToSegment(q,p1,p2))





