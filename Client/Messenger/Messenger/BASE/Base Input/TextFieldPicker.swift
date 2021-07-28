////
////  UITextField.swift
////  HOPNHAT
////
////  Created by Trọng Tín on 12/07/2021.
////
//
//import UIKit
//
//enum TypeAddTextField {
//    case room
//    case device
//}
//
//class TextFieldPicker: BaseInput {
//    var typeAdd = TypeAddTextField.room
//
//    let picker = UIPickerView()
//    var closureRoom: ((TypeRoom)->(Void))?
//    var closureDevice: ((TypeDevice)->(Void))?
//
//    func setup () {
//        self.textAlignment = .center
//        self.inputView = picker
//        self.tintColor = .clear
//        picker.dataSource = self
//        picker.delegate = self
//        pickerView(picker, didSelectRow: 0, inComponent: 0)
//    }
//}
//
//extension TextFieldPicker: UIPickerViewDelegate, UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
////            components
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return typeAdd == .room ? TypeRoom.allCases.count : TypeDevice.allCases.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        let cell = UIView()
//
//        let imageView = UIImageView()
//        let titleLabel = UILabel()
//
//        cell.addSubview(imageView)
//        cell.addSubview(titleLabel)
//
//        imageView.snp.makeConstraints { make in
//            make.centerY.equalTo(cell)
//            make.left.equalTo(cell.snp.left).offset(20)
//            make.height.equalTo(cell.snp.height).dividedBy(1.2)
//            make.width.equalTo(imageView.snp.height)
//        }
//        titleLabel.snp.makeConstraints { make in
//            make.centerY.equalTo(cell)
//            make.centerX.equalTo(cell.snp.centerX)
//            make.top.equalTo(imageView)
//        }
//        titleLabel.font = BaseFont.medium.value(size: 22)
//
//        switch typeAdd {
//        case .room:
//            imageView.image = TypeRoom(rawValue: row)?.getImage()
//            titleLabel.text = TypeRoom(rawValue: row)?.getTypeName()
//        case .device:
//            imageView.image = TypeDevice(rawValue: row)?.getImage()
//            titleLabel.text = TypeDevice(rawValue: row)?.getTypeName()
//        }
//        return cell
//    }
//
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return CGFloat(40)
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if typeAdd == .room {
//            let room = TypeRoom(rawValue: row)!
//            self.setupForImage(image: room.getImage(), distance: 15)
//            self.text = room.getTypeName()
//            closureRoom!(room)
//        } else {
//            let device = TypeDevice(rawValue: row)!
//            self.setupForImage(image: device.getImage(), distance: 15)
//            self.text = device.getTypeName()
//            closureDevice!(device)
//        }
//        self.setPadding(left: 50, right: 50)
//    }
//}
//
