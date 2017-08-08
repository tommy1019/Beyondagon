func pointOnCurve(controlPoints : [Vector3] , at t : Double) -> Vector3
{
    let b0 = ((1 - t) * (1 - t) * (1 - t)) * controlPoints[0]
    let b1 = (3 * t * (1 - t) * (1 - t)) * controlPoints[1]
    let b2 = (3 * t * t * (1 - t)) * controlPoints[2]
    let b3 = (t * t * t) * controlPoints[3]
    
    return b0 + b1 + b2 + b3
}

func pointOnPatch(controlPoints : [Vector3], at u : Double, _ v : Double) -> Vector3
{
    var res = [Vector3]()
    
    for i in 0 ..< 4
    {
        res.append(pointOnCurve(controlPoints: Array(controlPoints[4 * i ..< 4 * (i + 1)]), at: u))
    }
        
    return pointOnCurve(controlPoints: res, at: v)
}
