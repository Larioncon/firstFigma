//
//  ViewController.swift
//  firstFigma
//
//  Created by Chmil Oleksandr on 31.10.2024.
//

import UIKit


enum PayVariants: Int, CaseIterable {
    case small = 100
    case midle = 300
    case big   = 500
}


class ViewController: UIViewController {

    private lazy var textStack: UIStackView = {
     let stack = UIStackView()
     stack.axis = .vertical
     stack.spacing = 10
     stack.alignment = .leading
     stack.translatesAutoresizingMaskIntoConstraints = false
     return stack
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "img2")
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        // Определяем размеры для разных устройств
            let baseSize: CGFloat = 267 // Размер для iPhone 14
            let baseScreenHeight: CGFloat = 844 // Высота экрана для iPhone 14
            
            // Вычисляем пропорцию
            let screenHeight = UIScreen.main.bounds.height
            let size = baseSize * (screenHeight / baseScreenHeight)

            // Устанавливаем одинаковую ширину и высоту
            image.heightAnchor.constraint(equalToConstant: size).isActive = true
            image.widthAnchor.constraint(equalToConstant: size).isActive = true
            print(size)
        return image
    }()
    private lazy var payBtn: UIButton = {
        let btn = UIButton(primaryAction: payBtnAction)
        btn.setTitle("поддержать", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = UIColor(named: "DarkGreenColor")
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 51).isActive = true
        
        return btn
    }()
    private lazy var payBtnAction = UIAction { _ in
        print(self.selectPrice)
    }
    
    private var selectPrice = 100
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "MainColor")
        setCircles()
        setImage()
        setText()
        setVariants()
        setBtn()
    }
    
    private func setCircles() {
        let circleOne = createCircle(frame: CGRect(x: view.frame.width - 74, y: -28, width: 100, height: 100))
        circleOne.backgroundColor = .red
        let circleSecond = createCircle(frame: CGRect(x: 83, y: 100, width: 67, height: 67))
        let circleThird = createCircle(frame: CGRect(x: view.frame.width - 206, y: 216, width: 268, height: 268))
        let circleFourth = createCircle(frame: CGRect(x: 83, y: view.frame.height - 272, width: 56, height: 56))
        let circleFifth = createCircle(frame: CGRect(x: view.frame.width - 121, y: view.frame.height - 120, width: 97, height: 97))
        
        [circleOne, circleSecond, circleThird, circleFourth, circleFifth].forEach { item in view.addSubview(item)}
    }
    
    private func setImage() {
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
    
    private func setText() {
        view.addSubview(textStack)
        let pageTitle = createLabel(size: 30, weight: .bold, text: "Приложение и все его функции бесплатные")
        let pageSubtitle = createLabel(size: 16, weight: .regular, text: "все средства идут на улучшение и поддержку проекта")
        
        textStack.addArrangedSubview(pageTitle)
        textStack.addArrangedSubview(pageSubtitle)
        
        NSLayoutConstraint.activate([
            textStack.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 30),
            textStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
    }
    
    private func setVariants() {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.spacing = 0
        hStack.distribution = .equalSpacing
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hStack)
        PayVariants.allCases.forEach { variant in
            hStack.addArrangedSubview(createPayVariant(variant: variant))
        }
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: textStack.bottomAnchor, constant: 45),
            hStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])
    }
    
    private func setBtn() {
        view.addSubview(payBtn)
        NSLayoutConstraint.activate([
            payBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            payBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            payBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    @objc func selectVariant(sender: UIGestureRecognizer) {
        PayVariants.allCases.forEach { variant in
            if let sView = self.view.viewWithTag(variant.rawValue) {
                sView.layer.borderWidth = 0
                sView.layer.borderColor = .none
            }
            if let selectTag = sender.view?.tag {
                if let selectedView = self.view.viewWithTag(selectTag) {
                    selectedView.layer.borderWidth = 2
                    selectedView.layer.borderColor = UIColor.white.cgColor
                    self.selectPrice = selectTag
                }
            }
        }
        }
    
    // MARK: Create view
    
    private func createPayVariant(variant: PayVariants) -> UIView {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectVariant(sender: )))
        
        
        let payView = UIView()
        payView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
            payView.widthAnchor.constraint(equalToConstant: 100),
            payView.heightAnchor.constraint(equalToConstant: 100)
        ])
        payView.layer.cornerRadius = 20
        payView.tag = variant.rawValue
        payView.addGestureRecognizer(tapGesture)
        
        switch variant {
        case .small:
            payView.backgroundColor = UIColor(named: "OrangeColor")
            payView.layer.borderWidth = 2
            payView.layer.borderColor = UIColor.white.cgColor
        case .midle:
            payView.backgroundColor = UIColor(named: "PinkColor")
        case .big:
            payView.backgroundColor = UIColor(named: "DarkGreenColor")
        }
        
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 0
        vStack.alignment = .center
        vStack.translatesAutoresizingMaskIntoConstraints = false
        let summLabel = createLabel(size: 31, weight: .bold, text: "\(variant.rawValue)")
        let summSub = createLabel(size: 16, weight: .light, text: "гривен")
        vStack.addArrangedSubview(summLabel)
        vStack.addArrangedSubview(summSub)
        payView.addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: payView.topAnchor, constant: 23),
            vStack.bottomAnchor.constraint(equalTo: payView.bottomAnchor, constant: -23),
            vStack.trailingAnchor.constraint(equalTo: payView.trailingAnchor, constant: 10),
            vStack.leadingAnchor.constraint(equalTo: payView.leadingAnchor, constant: -10)
        ])
        
        return payView
    }
    
    private func createCircle(frame: CGRect) -> UIView {
        let circle = UIView()
        circle.backgroundColor = UIColor(named: "CircleColor")
        circle.frame = frame
        circle.layer.cornerRadius = frame.width/2
        return circle
    }
    private func createLabel(size: CGFloat, weight: UIFont.Weight, text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        
        return label
    }
}

