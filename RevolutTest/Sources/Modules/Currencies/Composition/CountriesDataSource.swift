//
//  CountriesDataSource.swift
//  RevolutTest
//
//  Created by Gregory Oberemkov on 07/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import Foundation

protocol CountriesDataSourceable {
    func fetchCountry(withAbbreviation abbreviation: String) -> CountryCurrencyModel
}

struct CountriesDataSource {
    private let countriesDictionary = ["EUR": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_eur"), title: "Euro"),
                                       "AUD": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_aud"), title: "Australian Dollar"),
                                       "BGN": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_bgn"), title: "Bulgarian Lev"),
                                       "BRL": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_brl"), title: "Brazilian Real"),
                                       "CAD": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_cad"), title: "Canadian Dollar"),
                                       "CHF": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_chf"), title: "Swiss Franc"),
                                       "CNY": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_cny"), title: "Yuan Renminbi"),
                                       "CZK": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_czk"), title: "Czech Koruna"),
                                       "DKK": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_dkk"), title: "Danish Krone"),
                                       "HKD": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_hkd"), title: "Hong Kong Dollar"),
                                       "HRK": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_hrk"), title: "Kuna"),
                                       "HUF": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_huf"), title: "Forint"),
                                       "IDR": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_idr"), title: "Rupiah"),
                                       "ILS": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_ils"), title: "New Israeli Sheqel"),
                                       "INR": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_inr"), title: "Indian Rupee"),
                                       "ISK": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_isk"), title: "Iceland Krona"),
                                       "JPY": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_jpy"), title: "Yen"),
                                       "KRW": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_krw"), title: "Won"),
                                       "MXN": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_mxn"), title: "Mexican peso"),
                                       "MYR": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_myr"), title: "Malaysian Ringgit"),
                                       "NOK": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_nok"), title: "Norwegian Krone"),
                                       "NZD": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_nzd"), title: "New Zealand Dollar"),
                                       "PHP": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_php"), title: "Philippine Peso"),
                                       "PLN": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_pln"), title: "Zloty"),
                                       "RON": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_ron"), title: "Romanian Leu"),
                                       "RUB": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_rub"), title: "Russian Ruble"),
                                       "SEK": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_sek"), title: "Swedish Krona"),
                                       "SGD": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_sgd"), title: "Singapore Dollar"),
                                       "THB": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_thb"), title: "Baht"),
                                       "TRY": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_try"), title: "Turkish Lira"),
                                       "USD": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_usd"), title: "US Dollar"),
                                       "ZAR": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_zar"), title: "Rand"),
                                       "GBP": CountryCurrencyModel(image: #imageLiteral(resourceName: "img_gbp"), title: "Pound Sterling")]
}

// MARK: - CountriesDataSourceable

extension CountriesDataSource: CountriesDataSourceable {

    func fetchCountry(withAbbreviation abbreviation: String) -> CountryCurrencyModel {
        return countriesDictionary[abbreviation] ?? CountryCurrencyModel(image: #imageLiteral(resourceName: "img_revolut"), title: "")
    }

}
