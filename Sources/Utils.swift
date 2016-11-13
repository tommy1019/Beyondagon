func printControlPoints(_ a : [Vector3])
{
    for i in 0 ..< a.count / 4
    {
        print("[[\(a[i * 4].x),\(a[i * 4].y)\(a[i * 4].z)] [\(a[i * 4 + 1].x),\(a[i * 4 + 1].y)\(a[i * 4 + 1].z)] [\(a[i * 4 + 2].x),\(a[i * 4 + 2].y)\(a[i * 4 + 2].z)] [\(a[i * 4 + 3].x),\(a[i * 4 + 3].y)\(a[i * 4 + 3].z)]]")
    }
}