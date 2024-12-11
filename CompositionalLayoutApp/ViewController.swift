//
//  ViewController.swift
//  CompositionalLayoutApp
//
//  Created by brubru on 29.11.2024.
//

import UIKit

class ViewController: UIViewController {
	private let reuseIdentifier = "reuseIdentifier"
	private var collectionView: UICollectionView!

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		configureCollectionView()
	}
}

private extension ViewController {
	func setupView() {
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
		collectionView.backgroundColor = .white
		collectionView.dataSource = self
		
		view.addSubview(collectionView)
	}
}

// MARK: - Settings Layout
private extension ViewController {
	func createLayout() -> UICollectionViewLayout {
		let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1), // половина ширины контейнера
            heightDimension: .fractionalHeight(0.33) // высота
		)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
		
			// Настройка группы
		let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.33),
            heightDimension: .fractionalHeight(0.5)
		)
		
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: 3
        )
    
			// Настройка секции
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .continuous // Горизонтальный скроллинг
		section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 2, bottom: 10, trailing: 0)
		
			// Создание компоновки
		return UICollectionViewCompositionalLayout(section: section)
	}
	
	func configureCollectionView() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
}

extension ViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		16
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
		cell.backgroundColor = .systemPink
		cell.layer.borderColor = UIColor.black.cgColor
		cell.layer.borderWidth = 3
		return cell
	}
}
