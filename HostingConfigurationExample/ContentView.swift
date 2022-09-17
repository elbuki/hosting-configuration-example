//
//  ContentView.swift
//  HostingConfigurationExample
//
//  Created by Marco Carmona on 9/14/22.
//
// This follows the tutorial on here: https://swiftsenpai.com/development/swiftui-custom-cell/
//

import UIKit
import SwiftUI

enum Section {
    case main
}

struct SFSymbolItem: Hashable {
    let name: String
    let image: UIImage?
    
    init(name: String) {
        self.name = name
        self.image = UIImage(systemName: name)
    }
}

class SwiftUICustomCellViewController: UIViewController {
    
    var collectionView: UICollectionView!
 
    let dataModel = [
        SFSymbolItem(name: "applelogo"),
        SFSymbolItem(name: "iphone"),
        SFSymbolItem(name: "message"),
        SFSymbolItem(name: "message.fill"),
        SFSymbolItem(name: "sun.min"),
        SFSymbolItem(name: "sun.min.fill"),
        SFSymbolItem(name: "sunset"),
        SFSymbolItem(name: "sunset.fill"),
        SFSymbolItem(name: "pencil"),
        SFSymbolItem(name: "pencil.circle"),
        SFSymbolItem(name: "highlighter"),
        SFSymbolItem(name: "network"),
        SFSymbolItem(name: "icloud"),
        SFSymbolItem(name: "icloud.fill"),
        SFSymbolItem(name: "car"),
        SFSymbolItem(name: "car.fill"),
        SFSymbolItem(name: "bus"),
        SFSymbolItem(name: "bus.fill"),
        SFSymbolItem(name: "flame"),
        SFSymbolItem(name: "flame.fill"),
        SFSymbolItem(name: "bolt"),
        SFSymbolItem(name: "bolt.fill")
    ]
    
    private var swiftUICellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, SFSymbolItem> = {
        
        .init { cell, indexPath, item in
            
            let hostingConfiguration = UIHostingConfiguration {
                
                HStack(alignment: .firstTextBaseline) {
                    Image(systemName: item.name)
                        .padding()
                    
                    Spacer()
                    
                    Text(item.name)
                        .font(.system(.title3, weight: .semibold))
                    
                    Spacer()
                    
                    Image(systemName: item.name)
                        .padding()
                }
                .frame(height: 70)
                .background {
                    RoundedRectangle(cornerRadius: 12.0)
                        .fill(Color(.systemYellow))
                }
                .alignmentGuide(.listRowSeparatorLeading) { $0[.leading] }
                .alignmentGuide(.listRowSeparatorTrailing) { $0[.trailing] }
                
            }.margins(.horizontal, 50)
            
            cell.contentConfiguration = hostingConfiguration
            
        }
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        
        collectionView = .init(frame: .zero, collectionViewLayout: listLayout)
        collectionView.dataSource = self
        view = collectionView
    }
    
}

extension SwiftUICustomCellViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = dataModel[indexPath.row]
        let cell = collectionView.dequeueConfiguredReusableCell(
            using: swiftUICellRegistration,
            for: indexPath,
            item: item
        )
        
        return cell
    }
    
}

struct UIViewControllerWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return SwiftUICustomCellViewController()
    }
    
    func updateUIViewController(
        _ uiViewController: UIViewControllerType,
        context: Context
    ) {}
    
}

struct ContentView: View {
    var body: some View = UIViewControllerWrapper()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
