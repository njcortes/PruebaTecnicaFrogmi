//
//  ViewController.swift
//  pruebaTecnica
//
//  Created by Nestor Cortés on 02-01-22.
//

import UIKit

class ViewController: UIViewController {

    var items: [Data] = []
    var isNetworkError = false
    var isLoading = false
    
    var nextUrl = "https://gorest.co.in/public/v1/users?page=2"
    
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "MyCustomHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "mycustomcell")
        
        //Register Loading Cell
        self.tableView.register(UINib(nibName: "MyCustomLoadingTableViewCell", bundle: nil), forCellReuseIdentifier: "loadingcell")

        
        //Register Error Cell
        self.tableView.register(UINib(nibName: "MyCustomErrorTableViewCell", bundle: nil), forCellReuseIdentifier: "errorcell")
     
        loadMoreData()
    }


    func loadMoreData() {
        print("loadMoreData init")
        
        
        if !self.isLoading {
            self.isLoading = true
            showTableActivityIndicator()
            DispatchQueue.global().async {

                //Trampa, evitar multiples llamadas
                sleep(2)
                NetworkingProvider.shared.getStores(){ (dataArr) in
                    self.isNetworkError = false
                    self.items.append(contentsOf:  dataArr.data)
                    self.tableView.reloadData()
                } failure: { (error) in
                    self.isNetworkError = true
                    self.hideTableActivityIndicator()
                    
                    let alert = UIAlertController(title: "Error", message: "THubo un error al traer los datos", preferredStyle: UIAlertController.Style.alert)

                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                    self.present(alert, animated: true, completion: nil)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.isLoading = false
                    self.hideTableActivityIndicator()
                }
            }
        }
    }
     
    func showTableActivityIndicator(){
        self.activityIndicator.startAnimating()
        self.activityIndicator.color = UIColor.black
    }
    
    
   func hideTableActivityIndicator(){
       self.activityIndicator.stopAnimating()
       self.activityIndicator.color = UIColor.white
   }
}

//MARK: - UITableViewDatasource
extension ViewController:UITableViewDataSource,UITableViewDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("extension  cell")
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "mycustomcell", for: indexPath) as! MyCustomHomeTableViewCell
            
            cell.lblName.text = items[indexPath.row].attributes?.name
            cell.lblCode.text = items[indexPath.row].attributes?.code
            cell.lblAdress.text = items[indexPath.row].attributes?.full_address
            return cell
        } else {
            
            if self.isNetworkError == false {
                let cell = tableView.dequeueReusableCell(withIdentifier: "mycustomcell", for: indexPath) as! MyCustomHomeTableViewCell
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "errorcell", for: indexPath) as! MyCustomErrorTableViewCell
                return cell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            return items.count
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44 //Item Cell height
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll init")
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (offsetY >= (contentHeight - scrollView.frame.size.height) && !isLoading) {
            loadMoreData()
        }
    }
}
