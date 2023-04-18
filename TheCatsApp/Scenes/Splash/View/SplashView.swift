//
//  SplashView.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 15/04/23.
//

import UIKit

final class SplashView: UIView {

    func setupUI() {
        self.backgroundColor = .white
        self.addSubview(firstProgressBar)
        firstProgressBar.snp.makeConstraints { make in
            make.top.equalTo(570)
            make.width.equalTo(240)
            make.height.equalTo(5)
            make.centerX.equalToSuperview()
        }
        stackView()
    }
    let firstProgressBar: LinearProgressBar = {
        let progressBar = LinearProgressBar()
        progressBar.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        progressBar.progressBarColor = #colorLiteral(red: 0.2661914229, green: 0.1873007119, blue: 0.4777578115, alpha: 1)
        progressBar.progressBarWidth = 4
        progressBar.cornerRadius = 2
        return progressBar
    }()
    func startAnimating() {
        [firstProgressBar].forEach {
            $0.startAnimating()
        }
    }
    func stopAnimating() {
        [firstProgressBar].forEach {
            $0.stopAnimating()
        }
    }
    func createImageBanner() -> UIImageView {
        let imageBanner = UIImageView()
        let image = Asset.SplashView.catLogo.image
        imageBanner.image = image
        imageBanner.frame = CGRect(x: 0, y: 0, width: 200.0, height: 80.0)
        imageBanner.contentMode = .scaleAspectFit
        return imageBanner
    }

    func stackView() {

        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 0.0

        stackView.addArrangedSubview(createImageBanner())
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(280)
            make.centerX.centerY.equalToSuperview()
        }
       
    }

    func show(title: String, message: String) {
       //alewrta de error
    }
}
