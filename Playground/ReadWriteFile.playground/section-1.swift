import Foundation

//
// Lendo do diretorio de documentos
//

let dirs : [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]

if dirs != nil {
	let dir = dirs![0]
	let path = dir.stringByAppendingPathComponent("teste.txt")
	let text = "some text"
	text.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding, error: nil)
	
	let text2 = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)
	text2
}

//
// Lendo do diretorio de recursos
//

let bundle = NSBundle.mainBundle()
let myPath = bundle.pathForResource("file", ofType: "txt")

let text3 = String(contentsOfFile: myPath!, encoding: NSUTF8StringEncoding, error: nil)
text3
