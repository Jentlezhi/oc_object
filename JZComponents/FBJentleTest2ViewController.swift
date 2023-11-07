//
//  FBJentleTest2ViewController.swift
//  fenbeitong
//
//  Created by Jentle-Zhi on 2023/3/7.
//  Copyright © 2023 FinHub. All rights reserved.
//

import Foundation
import FBKit
import Then

public class FBJentleTest2ViewController: FBViewController {
    /// 按钮
    private lazy var btn = UIButton().then {
        $0.setTitle("跳转", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
    }
    private lazy var planeIntDoubleFilter = FBPlaneIntlDoubleFilterToolView().then {
        let viewModel = FBPlaneIntlDoubleFilterToolViewModel()
        viewModel.isGo = true
        let model1 = FBPlaneIntBottomFilterItemModel()
        model1.normalTitle = "筛选"
        model1.otherSelectedTitle = "筛选"
        model1.defaultSelectedTitle = "筛选"
        model1.state = .normal
        model1.needArrow = true
        
        let model2 = FBPlaneIntBottomFilterItemModel()
        model2.normalTitle = "时间"
        model2.defaultSelectedTitle = "时间从早到晚"
        model2.otherSelectedTitle = "时间从晚到早"
        
        let model3 = FBPlaneIntBottomFilterItemModel()
        model3.normalTitle = "价格"
        model3.defaultSelectedTitle = "价格从低到高"
        model3.otherSelectedTitle = "价格从高到低"
        
        
        viewModel.dataSource = [model1,model2,model3]
        $0.viewModel = viewModel
        $0.backgroundColor = .randomColor()
        view.addSubview($0)
    }
    @objc func btnAction() {
//        filterView.show(onView: self.view)
        return
    }
    func setupViwes() {
        view.addSubview(btn)
        btn.snp.makeConstraints {
            $0.center.equalTo(view)
        }
        planeIntDoubleFilter.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50.0)
            $0.centerY.equalToSuperview()
        }
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViwes()
    }
    
    
}
