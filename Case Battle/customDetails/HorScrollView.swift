//
//  OpenAnimView.swift
//  Case Battle
//
//  Created by Mark Vadimov on 30.04.24.
//

import SwiftUI

struct HorizontalScrollableView<Content: View>: UIViewControllerRepresentable, Equatable {
    
    // MARK: - Coordinator
    final class Coordinator: NSObject, UIScrollViewDelegate {
        
        // MARK: - Properties
        private let scrollView: UIScrollView
        var offset: Binding<CGPoint>
        
        // MARK: - Init
        init(_ scrollView: UIScrollView, offset: Binding<CGPoint>) {
            self.scrollView = scrollView
            self.offset = offset
            super.init()
            self.scrollView.delegate = self
        }
        
        // MARK: - UIScrollViewDelegate
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            DispatchQueue.main.async {
                self.offset.wrappedValue = scrollView.contentOffset
            }
        }
    }
    
    // MARK: - Type
    typealias UIViewControllerType = UIScrollViewController<Content>
    
    // MARK: - Properties
    var offset: Binding<CGPoint>
    var animationDuration: TimeInterval
    var showsScrollIndicator: Bool
    var content: () -> Content
    var stopScrolling: Binding<Bool>
    private let scrollViewController: UIViewControllerType
    
    // MARK: - Init
    init(_ offset: Binding<CGPoint>, animationDuration: TimeInterval, showsScrollIndicator: Bool = true, stopScrolling: Binding<Bool> = .constant(false), @ViewBuilder content: @escaping () -> Content) {
        self.offset = offset
        self.animationDuration = animationDuration
        self.showsScrollIndicator = showsScrollIndicator
        self.content = content
        self.stopScrolling = stopScrolling
        self.scrollViewController = UIScrollViewController(rootView: self.content(), offset: self.offset)
    }
    
    // MARK: - Updates
    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> UIViewControllerType {
        self.scrollViewController
    }
    
    func updateUIViewController(_ viewController: UIViewControllerType, context: UIViewControllerRepresentableContext<Self>) {
        
        viewController.scrollView.showsVerticalScrollIndicator = self.showsScrollIndicator
        viewController.scrollView.showsHorizontalScrollIndicator = self.showsScrollIndicator
        viewController.updateContent(self.content)
        
        let duration: TimeInterval = self.duration(viewController)
        let newValue: CGPoint = self.offset.wrappedValue
        
        if self.stopScrolling.wrappedValue {
            viewController.scrollView.setContentOffset(viewController.scrollView.contentOffset, animated: false)
            return
        }
        
        guard duration != .zero else {
            viewController.scrollView.contentOffset = newValue
            return
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: [.allowUserInteraction, .curveEaseInOut, .beginFromCurrentState], animations: {
            viewController.scrollView.contentOffset = newValue
        }, completion: nil)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self.scrollViewController.scrollView, offset: self.offset)
    }
    
    // Calculate animation speed
    private func duration(_ viewController: UIViewControllerType) -> TimeInterval {
        
        let diff = abs(viewController.scrollView.contentOffset.x - self.offset.wrappedValue.x)
        
        if diff == 0 {
            return .zero
        }
        
        let percentageMoved = diff / UIScreen.main.bounds.width
        
        return self.animationDuration * min(max(TimeInterval(percentageMoved), 0.25), 1)
    }
    
    // MARK: - Equatable
    static func == (lhs: HorizontalScrollableView, rhs: HorizontalScrollableView) -> Bool {
        return false
    }
}

final class UIScrollViewController<Content: View> : UIViewController, ObservableObject {
    
    // MARK: - Properties
    var offset: Binding<CGPoint>
    let hostingController: UIHostingController<Content>
    lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.canCancelContentTouches = true
        scrollView.delaysContentTouches = true
        scrollView.scrollsToTop = false
        scrollView.backgroundColor = .clear
        
        return scrollView
    }()
    
    // MARK: - Init
    init(rootView: Content, offset: Binding<CGPoint>) {
        self.offset = offset
        self.hostingController = UIHostingController<Content>(rootView: rootView)
        self.hostingController.view.backgroundColor = .clear
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Update
    func updateContent(_ content: () -> Content) {
        
        self.hostingController.rootView = content()
        self.scrollView.addSubview(self.hostingController.view)
        
        let contentSize = self.hostingController.view.intrinsicContentSize
        self.hostingController.view.frame.size = contentSize
        self.scrollView.contentSize = contentSize
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.scrollView)
        self.createConstraints()
    }
    
    // MARK: - Constraints
    fileprivate func createConstraints() {
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
