//
//  Library.swift
//  MusicApp
//
//  Created by Stanly Shiyanovskiy on 21.01.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import SwiftUI
import URLImage

struct Library: View {
    
    @State var tracks = UserDefaults.standard.getSavedTracks()
    @State private var showingAlert = false
    @State private var track: StoredCell!
    
    var tabBarDelegate: MainTabBarControllerDelegate?
    
    var body: some View {
        NavigationView{
            VStack {
                GeometryReader { geometry in
                    HStack(spacing: 20) {
                        Button(action: {
                            self.track = self.tracks[0]
                            let model = SearchViewModel.Cell(model: self.track)
                            self.tabBarDelegate?.maximizeTrackDetailController(viewModel: model)
                        }, label: {
                            Image(systemName: "play.fill")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(Color(#colorLiteral(red: 1, green: 0, blue: 0.3764705882, alpha: 1)))
                                .background(Color(#colorLiteral(red: 0.9531342387, green: 0.9490900636, blue: 0.9562709928, alpha: 1)))
                                .cornerRadius(10)
                        })
                        Button(action: {
                            self.tracks = UserDefaults.standard.getSavedTracks()
                        }, label: {
                            Image(systemName: "arrow.2.circlepath")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(Color(#colorLiteral(red: 1, green: 0, blue: 0.3764705882, alpha: 1)))
                                .background(Color(#colorLiteral(red: 0.9531342387, green: 0.9490900636, blue: 0.9562709928, alpha: 1)))
                                .cornerRadius(10)
                        })
                    }
                }.padding().frame(height: 50)
                Divider().padding(.leading).padding(.trailing)
                
                List {
                    ForEach(tracks) { track in
                        LibraryCell(cell: track).gesture(
                            LongPressGesture()
                                .onEnded { _ in
                                    self.track = track
                                    self.showingAlert = true
                                }
                                .simultaneously(with: TapGesture()
                                    .onEnded { _ in
                                        let keyWindow = UIApplication.shared.connectedScenes.filter({ $0.activationState == .foregroundActive }).map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows.filter({ $0.isKeyWindow }).first
                                        let tabBarVC = keyWindow?.rootViewController as? MainTabBarController
                                        tabBarVC?.trackDetailView.delegate = self
                                        self.track = track
                                        let model = SearchViewModel.Cell(model: track)
                                        self.tabBarDelegate?.maximizeTrackDetailController(viewModel: model)
                                    }))
                    }.onDelete(perform: delete)
                }
            }
            .actionSheet(isPresented: $showingAlert, content: { ActionSheet(title: Text("Are you sure you want delete this track?"), buttons: [.destructive(Text("Delete"), action: {
                self.delete(track: self.track)
            }), .cancel()])
            })
                .navigationBarTitle("Library")
        }
    }
    
    func delete(at offsets: IndexSet) {
        tracks.remove(atOffsets: offsets)
        let stored = SearchViewStoredModel(cells: tracks)
        UserDefaults.standard.saveTracks(tracksModel: stored)
    }
    
    func delete(track: StoredCell) {
        let index = tracks.firstIndex(of: track)
        guard let currentIndex = index else { return }
        tracks.remove(at: currentIndex)
        let stored = SearchViewStoredModel(cells: tracks)
        UserDefaults.standard.saveTracks(tracksModel: stored)
    }
}

struct LibraryCell: View {
    
    var cell: StoredCell
    
    var body: some View {
        HStack {
            URLImage(URL(string: cell.iconUrlString ?? "")!) { proxy in
                proxy.image
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(2)
            }
            VStack(alignment: .leading) {
                Text("\(cell.trackName)")
                Text("\(cell.artistName)")
            }
        }
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}

extension Library: TrackMovingDelegate {
    func moveBackForPreviousTrack() -> SearchViewModel.Cell? {
        guard let index = tracks.firstIndex(of: track) else { return nil }
        var nextTrack: StoredCell
        if index - 1 == -1 {
            nextTrack = tracks[tracks.count - 1]
        } else {
            nextTrack = tracks[index - 1]
        }
        track = nextTrack
        
        return SearchViewModel.Cell(model: nextTrack)
    }
    
    func moveForwardForPreviousTrack() -> SearchViewModel.Cell? {
        guard let index = tracks.firstIndex(of: track) else { return nil }
        var nextTrack: StoredCell
        if index + 1 == tracks.count {
            nextTrack = tracks[0]
        } else {
            nextTrack = tracks[index + 1]
        }
        track = nextTrack
        
        return SearchViewModel.Cell(model: nextTrack)
    }
}
