//
//  NewNoteViewController.swift
//  Notes
//
//  Created by Дмитрий Старков on 10.03.2022.
//

import UIKit

class NewNoteViewController: UIViewController {
    
    var isNewNote = true // true - новая заметка, false - редактирование
    var editNote = NoteModel() // свойство для сохранения редаактируемой заметки
    
    let nameTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.7)
        textView.textAlignment = .left
        textView.autocapitalizationType = .words
        textView.isScrollEnabled = false
        textView.insertText("Название...")
        textView.font = .systemFont(ofSize: 25, weight: .medium)
        return textView
    }()

    
    let noteTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.5)
        textView.textAlignment = .left
        textView.insertText("Текст Заметки...")
        textView.font = .systemFont(ofSize: 20, weight: .light)
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupNavBar()
        
        view.addSubview(nameTextView)
        view.addSubview(noteTextView)
    
    }
    
    private func setupNavBar(){
        let barButton = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(didTapSaveNote))
        navigationItem.rightBarButtonItem = barButton
    }
    


    @objc private func didTapSaveNote() {
        guard let name = nameTextView.text,
              let textOfNote = noteTextView.text else { return }
       
        let note = NoteModel(name: name, textOfNote: textOfNote,id: UUID().uuidString)
        if isNewNote {
            StorageManager.saveObject(note)
        } else {
            StorageManager.updateObject(editNote, name: name, textOfNote: textOfNote)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        nameTextView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                            leading: view.leadingAnchor,
                            bottom: nil,
                            trailing: view.trailingAnchor,
                            size: CGSize(width: 0, height: view.frame.width/6))

        noteTextView.anchor(top: nameTextView.bottomAnchor,
                            leading: view.leadingAnchor,
                            bottom: view.bottomAnchor,
                            trailing: view.trailingAnchor)
    }

}

