//
//  PlainBackground.swift
//  Climb
//
//  Created by Hadi Chamas  on 6/2/23.
//

import SwiftUI
import AVFoundation

struct PlainBackground: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var videoURL: URL?

    var body: some View {
        VideoPlayerView(videoURL: videoURL)
            .onChange(of: colorScheme) { newColorScheme in
                updateVideoURL(for: newColorScheme)
            }
            .onAppear {
                updateVideoURL(for: colorScheme)
            }
    }

    private func updateVideoURL(for colorScheme: ColorScheme) {
        let fileName = colorScheme == .dark ? "DMBackgroundPlain" : "LMBackgroundPlain"
        if let url = Bundle.main.url(forResource: fileName, withExtension: "mov") {
            videoURL = url
        }
    }
}

struct VideoPlayer2View: UIViewRepresentable {
    let videoURL: URL?

    func makeUIView(context: Context) -> UIView {
        let view = QueuePlayerUIView(frame: .zero)
        view.playerLayer.videoGravity = .resizeAspectFill
        return view
    }

    func updateUIView(_ uiview: UIView, context: Context) {
        guard let view = uiview as? QueuePlayerUIView2 else { return }
        view.updateVideoURL(videoURL)
    }
}

class QueuePlayerUIView2: UIView {
    let playerLayer = AVPlayerLayer()
    var playerLooper: AVPlayerLooper?
    var player: AVQueuePlayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlayer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPlayer() {
        // Create player
        let player = AVQueuePlayer()
        self.player = player
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
    }

    func updateVideoURL(_ videoURL: URL?) {
        guard let videoURL = videoURL else {
            player?.pause()
            player?.removeAllItems()
            return
        }

        // Load video
        let playerItem = AVPlayerItem(url: videoURL)

        // Remove existing items and add the new item
        player?.removeAllItems()
        player?.insert(playerItem, after: nil)

        // Loop
        playerLooper = AVPlayerLooper(player: player!, templateItem: playerItem)

        // Play
        player?.play()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Adjust the frame of the playerLayer to fill the entire screen, ignoring the top and bottom safe areas
        let scenes =  UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        if let window = windowScenes?.windows.first {
            let safeInsets = window.safeAreaInsets
            let playerFrame = CGRect(x: 0, y: -safeInsets.top, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + safeInsets.top + safeInsets.bottom)
            playerLayer.frame = playerFrame
        }
    }
}

struct PlainBackground_Previews: PreviewProvider {
    static var previews: some View {
        PlainBackground()
    }
}

