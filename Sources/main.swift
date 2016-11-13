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

for i in 0 ..< numVectors
{
    let curLine = lines[numPatches + 2 + i].components(separatedBy: ",")
    
    let x = Double(curLine[0])!
    let y = Double(curLine[1])!
    let z = Double(curLine[2])!
    
    print("<\(x),\(y),\(z)>")
}

for i in 0 ..< numPatches
{
    print(i)
}
