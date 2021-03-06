//
//  XmlWriter.swift
//  snacks
//
//  Created by noear on 16/2/21.
//  Copyright © 2016年 noear. All rights reserved.
//

import Foundation

class XmlWriter {
    private var _writer:StringBuilder!;
    
    init(_ writer:StringBuilder)
    {
        _writer = writer;
    }
    
    
    func WriteNodeStart(_ nodeName:String)
    {
        _writer.append("<");
        _writer.append(nodeName);
        _writer.append(">");
    }
    
    func WriteNodeEnd(_  nodeName:String)
    {
        _writer.append("<");
        _writer.append("/");
        _writer.append(nodeName);
        _writer.append(">");
    }
    
    func WriteCDATAValue(_  str:String?)
    {
        if (str == nil)
        {
            return;
        }
        
        _writer.append("<![CDATA[");
        _writer.append(str!);
        _writer.append("]]>");
    }
    
    func WriteValue(_  str:String?)
    {
        if (str == nil){
            return;
        }
        
        for c in str!.characters
        {
            if (c == "<") //5个xml转义符
            {
                _writer.append("&lt;");
            }
            else if (c == ">")
            {
                _writer.append("&gt;");
            }
            else if (c == "&")
            {
                _writer.append("&amp;");
            }
            else
            {
                _writer.append(c);
            }
        }
    }
    
    func WriteValue(_  value:Int32)
    {
        _writer.append(value);
    }
    
    func WriteValue(_  value:Int64)
    {
        _writer.append(value);
    }
    
    func WriteValue(_  value:Double)
    {
        _writer.append(value);
    }
    
    
    func WriteValue(_  value:Bool)
    {
        if (ONode.BOOL_USE01)
        {
            _writer.append(value ? "1" : "0");
        }
        else
        {
            _writer.append(value ? "true" : "false");
        }
    }
    
    func WriteValue(_  value:Date)
    {
        _writer.append(ONode.TIME_FORMAT_ACTION(value));
    }
    
    func WriteValue(_  val:OValue)
    {
        switch (val.type)
        {
        case .Int:WriteValue(val.getInt());break;
        case .Long:WriteValue(val.getLong());break;
        case .Double:WriteValue(val.getDouble());break;
        case .String:WriteValue(val.getString());break;
        case .Boolean:WriteValue(val.getBoolean());break;
        case .DateTime:WriteValue(val.getDate()!);break;
        case .Null:WriteValue("");break;
        }
    }
}
