//
//  NotesViewController.swift
//  Notes
//
//  Created by Дмитрий Старков on 09.03.2022.
//

import UIKit
import RealmSwift

class NotesViewController: UIViewController {
    
    private var notes: Results<NoteModel>!
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width - 20 , height: width/3 )
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        notes = realm.objects(NoteModel.self)
        isFirstStart()
        setupNavBar()
        setupCollectionView()
    }
    
    private func isFirstStart() {
        if notes.isEmpty {
            let note = NoteModel(name: "Первая заметка", textOfNote: "Введите текст",id: UUID().uuidString)
            StorageManager.saveObject(note)
        }
    }
    
    private func setupNavBar() {
        let addNewNoteButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewNote))
        navigationItem.rightBarButtonItem = addNewNoteButton
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongTapFromDelete))
        collectionView.addGestureRecognizer(longPressGesture)
    }

    @objc private func addNewNote() {
        let vc = NewNoteViewController()
        vc.title = "Новая Заметка"
        vc.isNewNote = true
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
        //долгое нажатие для удаления заметки
    @objc private func didLongTapFromDelete(_ gesture: UILongPressGestureRecognizer) {
        
        let gestureLocation = gesture.location(in: self.collectionView)
        guard let targetIndexPath = self.collectionView.indexPathForItem(at: gestureLocation) else { return }

        let alert = UIAlertController(title: "Удалить Заметку?",
                                            message: nil, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
            guard let strongSelf = self else { return }
            
            let deleteNote = strongSelf.notes[targetIndexPath.row]
                StorageManager.deleteObject(deleteNote)
                strongSelf.collectionView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(deleteAction)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }

}

//MARK: - collectionViewDataSourse, collectionViewDelegate

extension NotesViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !notes.isEmpty {
            return notes.count
        } else {
            return 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NoteCollectionViewCell
       
            let model = notes[indexPath.row]
            cell.configure(with: model)
            return cell
        
    }
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = NewNoteViewController()
        vc.title = "Редактирование"
        vc.navigationItem.largeTitleDisplayMode = .never
        
        let model = notes[indexPath.row]
        
        vc.editNote = model
        vc.nameTextView.text = model.name
        vc.noteTextView.text = model.textOfNote
        vc.isNewNote = false
       
        navigationController?.pushViewController(vc, animated: true)
    }
   
}


