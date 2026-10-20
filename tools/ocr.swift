import Foundation
import Vision
import AppKit

// 用法: ocr <图片路径> [语言: zh-Hans 默认]
let args = CommandLine.arguments
guard args.count > 1 else { print("usage: ocr <image>"); exit(1) }
let path = args[1]
guard let img = NSImage(contentsOfFile: path) else { print("cannot load"); exit(2) }
guard let cg = img.cgImage(forProposedRect: nil, context: nil, hints: nil) else { print("no cgimage"); exit(3) }

let req = VNRecognizeTextRequest { request, error in
    guard let obs = request.results as? [VNRecognizedTextObservation] else { return }
    // 按屏幕位置从上到下、从左到右排序
    let sorted = obs.sorted { a, b in
        if abs(a.boundingBox.midY - b.boundingBox.midY) > 0.012 { return a.boundingBox.midY > b.boundingBox.midY }
        return a.boundingBox.minX < b.boundingBox.minX
    }
    for o in sorted {
        if let t = o.topCandidates(1).first {
            let r = o.boundingBox
            print(String(format: "[%.2f,%.2f] %@", r.minX, r.midY, t.string))
        }
    }
}
req.recognitionLanguages = ["zh-Hans", "en-US"]
req.usesLanguageCorrection = true
req.recognitionLevel = .accurate

let handler = VNImageRequestHandler(cgImage: cg, options: [:])
do { try handler.perform([req]) } catch { print("OCR err: \(error)"); exit(4) }
