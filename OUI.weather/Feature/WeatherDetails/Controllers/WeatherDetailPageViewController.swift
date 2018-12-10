//
//  WeatherDetailPageViewController.swift
//  OUI.weather
//
//  Created by Rachid Mahmoud on 07/12/2018.
//  Copyright © 2018 Rachid Mahmoud. All rights reserved.
//

import UIKit

class WeatherDetailPageViewController: UIPageViewController {
    
    var city: City?
    var weathers: [(key: String, value: [Weather])]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        self.configUI()
    }
    
    private lazy var orderedViewControllers: [UIViewController] = {
        var controllers = [UIViewController]()
        if let weathers = weathers {
            for weather in weathers {
                if let dvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherDetailViewController") as? WeatherDetailViewController {
                    dvc.weatherList = weather.value
                    dvc.city = city
                    controllers.append(dvc)
                }
            }
            return controllers
        }
        return []
    }()
    
    private func configUI() {
        if let firstViewController = orderedViewControllers.first as? WeatherDetailViewController {
            firstViewController.index = 0
            firstViewController.weatherList = Array(weathers!)[0].value
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    @IBAction func closeDetailViewAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension WeatherDetailPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of:viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of:viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}
