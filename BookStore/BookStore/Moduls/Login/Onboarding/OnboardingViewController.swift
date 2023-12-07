//
//  OnboardingViewController.swift
//  BookStore
//
//  Created by Alexander Altman on 05.12.2023.
//

import UIKit
import Lottie
import SnapKit

final class OnboardingViewController: UIViewController {
    
    //MARK: - Elements
    private let firstOnboardingScreen = PagesViewController()
    private let secondOnboardingScreen = PagesViewController()
    private let thirdOnboardingScreen = PagesViewController()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.contentInsetAdjustmentBehavior = .scrollableAxes
        return scrollView
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backSlide02")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.preferredIndicatorImage = UIImage(named: "pageActiveIndicator")
        pageControl.pageIndicatorTintColor = .customDarkGray
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.addTarget(self, action: #selector(pageControlIndicatorTapped(sender:)), for: .valueChanged)
        return pageControl
    }()
    
    private var slides = [PagesViewController]()
    
    //MARK: - Life Cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        slides = createSlides()
        setupSlidesScrollView(slides: slides)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstrints()
        setDelegates()
        buttonsTapped()
    }
    
    //MARK: - Private Methods
    @objc private func pageControlIndicatorTapped(sender: UIPageControl) {
        let offsetX = view.bounds.width * CGFloat(pageControl.currentPage)
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    private func setupViews() {
        view.backgroundColor = .red
        navigationController?.isNavigationBarHidden = true
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundImageView)
        view.addSubview(pageControl)
    }
    
    private func setDelegates() {
        scrollView.delegate = self
    }
    
    private func makeText(text1: String, text2: String) -> NSAttributedString {
        var seaGreenAttribute = [NSAttributedString.Key: AnyObject]()
        seaGreenAttribute[.foregroundColor] = UIColor.orange
        
        var blueAttribute = [NSAttributedString.Key: AnyObject]()
        blueAttribute[.foregroundColor] = UIColor.white
        
        let text = NSMutableAttributedString(string: text1, attributes: blueAttribute)
        text.append(NSAttributedString(string: text2, attributes: seaGreenAttribute))
        
        return text
    }
    
    private func createSlides() -> [PagesViewController] {
        firstOnboardingScreen.setPageLabelText(text: makeText(text1: "Millions of books from ",
                                                              text2: "all over the world!"),
                                               text2: makeText(text1: "Search for the book which fits your interests or mood. ",
                                                               text2: "You'll find what you'd like for sure"))
        firstOnboardingScreen.hideContinueButton()
        
        secondOnboardingScreen.setPageLabelText(text: makeText(text1: "Read online or ",
                                                               text2: "save it for later"),
                                                text2: makeText(text1: "You can add your favoirite book to your library ",
                                                                text2: "to have access to it just on fingertip"))
        secondOnboardingScreen.animationView.animation = LottieAnimation.named("Animation - 2")
        secondOnboardingScreen.hideContinueButton()
        
        thirdOnboardingScreen.setPageLabelText(text: makeText(text1: "Read more and stress less ",
                                                              text2: "with our reading app"),
                                               text2: makeText(text1: "It doesn't matter what you're interested in. ",
                                                               text2: "Happy reading"))
        thirdOnboardingScreen.animationView.animation = LottieAnimation.named("Animation - 3")
        thirdOnboardingScreen.hideSkipNextButtons()
        
        return [firstOnboardingScreen, secondOnboardingScreen, thirdOnboardingScreen]
    }
    
    private func setupSlidesScrollView(slides: [PagesViewController]) {
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count),
                                        height: view.frame.height)
        
        for i in 0..<slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i),
                                     y: 0,
                                     width: view.frame.width,
                                     height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    private func buttonsTapped() {
        firstOnboardingScreen.skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        firstOnboardingScreen.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        secondOnboardingScreen.skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        secondOnboardingScreen.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        thirdOnboardingScreen.continueButton.addTarget(self, action: #selector(continueButtonTapped(_:)), for: .primaryActionTriggered)
    }
    
    //MARK: - Objc Private Methods
    @objc private func skipButtonTapped() {
        let vc = MainTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc private func nextButtonTapped() {
        pageControl.currentPage += 1
        
        let xOffset = scrollView.contentOffset.x + scrollView.bounds.width
        let contentOffset = CGPoint(x: xOffset, y: scrollView.contentOffset.y)
        scrollView.setContentOffset(contentOffset, animated: true)
    }
    
    @objc private func continueButtonTapped(_ sender: UIButton) {
        let vc = MainTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

//MARK: - UIScrollViewDelegate
extension OnboardingViewController: UIScrollViewDelegate, UIPageViewControllerDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maxHOffset = scrollView.contentSize.width - view.frame.width
        let percentHOffset = scrollView.contentOffset.x / maxHOffset
        
        if percentHOffset <= 0.5 {
            let firstTransformation = CGAffineTransform(scaleX: (0.5 - percentHOffset) / 0.5,
                                                        y: (0.5 - percentHOffset) / 0.5)
            let secondTransformation = CGAffineTransform(scaleX: percentHOffset / 0.5,
                                                         y: percentHOffset / 0.5)
            slides[0].setTransformWith(transform: firstTransformation)
            slides[1].setTransformWith(transform: secondTransformation)
        } else {
            let secondTransformation = CGAffineTransform(scaleX: (1 - percentHOffset) / 0.5,
                                                         y: (1 - percentHOffset) / 0.5)
            let thirdTransformation = CGAffineTransform(scaleX: percentHOffset,
                                                        y: percentHOffset)
            slides[1].setTransformWith(transform: secondTransformation)
            slides[2].setTransformWith(transform: thirdTransformation)
        }
    }
}

//MARK: - Set Constraints
extension OnboardingViewController {
    private func setConstrints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(view.frame.height / 2)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
            make.height.equalTo(50)
        }
    }
}
