import Foundation

let path = "Resources/teapot"        

let fileContents : String

do
{
    fileContents = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
}
catch
{
    print("Error reading ")
    fileContents = ""
}

let lines = fileContents.components(separatedBy: "\n")

let numPatches = Int(lines[0])!
let numVectors = Int(lines[numPatches + 1])!
print("Loading curve file with \(numPatches) patches and \(numVectors) vectors")

var vectors = [Vector3]()

for i in 0 ..< numVectors
{
    let curLine = lines[numPatches + 2 + i].components(separatedBy: ",")
    
    let x = Double(curLine[0])!
    let y = Double(curLine[1])!
    let z = Double(curLine[2])!
    
    let vec = Vector3(x, y, z)
    vectors.append(vec)
}

for i in 0 ..< numPatches
{
    let patchVectors = lines[i + 1].components(separatedBy: ",").map{ vectors[Int($0)! - 1] }
    
    let resolution = 4
    
    for u in 0 ..< resolution
    {
        for v in 0 ..< resolution
        {
            let resVector = pointOnPatch(controlPoints: patchVectors, at: Double(u), Double(v))
        }
    }
    
    print(patchVectors)
}