(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit ValidationErrorHandler;

interface

{$MODE OBJFPC}
{$H+}

uses

    fano;

type

    (*!-----------------------------------------------
     * controller that display validation error message
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TValidationErrorHandler = class(TAbstractController)
    private
        fValidator : IRequestValidator;
    public
        constructor create(const validator : IRequestValidator);
        function handleRequest(
            const request : IRequest;
            const response : IResponse;
            const args : IRouteArgsReader
        ) : IResponse; override;
    end;

implementation

uses

    SysUtils;

    constructor TValidationErrorHandler.create(const validator : IRequestValidator);
    begin
        fValidator := validator;
    end;

    function TValidationErrorHandler.handleRequest(
        const request : IRequest;
        const response : IResponse;
        const args : IRouteArgsReader
    ) : IResponse;
    var
        validationRes : TValidationResult;
        body : IResponseStream;
        i : integer;
    begin
        validationRes := fValidator.lastValidationResult();
        body := response.body();
        body.write('<html><head></head><body><ul>');
        for i := 0 to length(validationRes.errorMessages) - 1 do
        begin
            body.write(format('<li>%s</li>', [validationRes.errorMessages[i].errorMessage]));
        end;
        body.write('</ul></body></html>');
        result := response;
    end;

end.
