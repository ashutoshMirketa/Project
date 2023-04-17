public class CreateProductRecord {
    public static HttpResponse createRecord() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://fakestoreapi.com/products');
        req.setMethod('GET');

        Http http = new Http();
        HTTPResponse res = http.send(req);
        

        if (res.getStatusCode() == 200) {
            String response = res.getBody();
            //System.debug(response);
            
            List<Object> productList = (List<Object>) JSON.deserializeUntyped(response);
            //System.debug(productList);

            //Lists to Insert : 
	        List<Product2> productEntryList = new List<Product2>();
            List<PricebookEntry> stdPBEntryList = new List<PricebookEntry>();
            List<PricebookEntry> customPBEntryList = new List<PricebookEntry>();

			// Pricebook2 standardPB = [select id from Pricebook2 where isStandard=true];
			// 
			
			Pricebook2 standardPB = new Pricebook2();
            
            if(Test.isRunningTest()){
                id pbid =Test.getStandardPricebookId();
                standardPB.id = pbid;
             } else {
				standardPB = [select id from Pricebook2 where isStandard = true];
             }
            
            Pricebook2 pb = new Pricebook2(Name = 'ashutoshsingh-pricebook', Description = 'Price Book', IsActive = true);
            insert pb;
                        
            System.debug('------'+productList.size());
            
            for (Object product : productList) {
                
                //System.debug(product);
                Map<String, Object> productMap = (Map<String, Object>) product;
                

                String title = (String) JSON.serialize(productMap.get('title'));
                title = title.substring(1, title.length() - 1);
                
                String descript = (String) JSON.serialize(productMap.get('description'));
                descript = descript.substring(1, descript.length() - 1);


                Product2 pro = new Product2(
                    ProductCode = (String) JSON.serialize(productMap.get('id')),
                    Name = title,
                    Description = descript
                );

                productEntryList.add(pro);
            }

            insert productEntryList;

            for (integer i = 0; i < productList.size(); i++) {
                Object product = productList.get(i);
                Id productId = productEntryList.get(i).Id;

                Map<String, Object> productMap = (Map<String, Object>) product;

                Decimal strToDec = decimal.valueOf(JSON.serialize(productMap.get('price')));

                PricebookEntry entry = new PricebookEntry(
                    Pricebook2Id = standardPB.Id,
                    Product2Id = productId,
                    UnitPrice = strToDec,
                    IsActive = true
                );

                stdPBEntryList.add(entry);
            }
            
			insert stdPBEntryList;

            
            for (integer i = 0; i < productList.size(); i++) {
                Object product = productList.get(i);
                Id productId = productEntryList.get(i).Id;

                Map<String, Object> productMap = (Map<String, Object>) product;

                Decimal strToDec = decimal.valueOf(JSON.serialize(productMap.get('price')));
                
                PricebookEntry entry = new PricebookEntry(
                    Pricebook2Id = pb.Id,
                    Product2Id = productId,
                    UnitPrice = strToDec,
                    IsActive = true
                );

                customPBEntryList.add(entry);
            }
            
            insert customPBEntryList;
            
            System.debug('Ashutosh '+customPBEntryList.size());
        }
        return res;

    }
}